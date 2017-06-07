defmodule Wep.OmdbFetcher do

  alias Wep.Show
  alias Wep.Season
  alias Wep.Episode
  alias Wep.Repo

  import Ecto.Query, only: [from: 2, first: 1]

  @base_url "http://www.omdbapi.com/"
  @api_key "6fefe083"
  # fetches and stores show + seasons + episodes from imdb
  # returns nothing useful
  def fetch(title) do
    query_url = URI.encode("#{@base_url}?t=#{title}&type=series&apikey=#{@api_key}")
    
    case HTTPoison.get query_url do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_and_create_show(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Show not found")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts(reason)
    end
  end

  def parse_and_create_show(body) do
    case Poison.decode(body) do
      {:error, reason} -> IO.puts(reason)
      {:ok, %{ "Error" => error }} -> IO.puts error
      {:ok, %{ "totalSeasons" => total_seasons } = body} ->
        case Integer.parse total_seasons do
          :error -> IO.puts "No seasons"
          {total_seasons, _} when total_seasons > 0 ->
            # build params from response
            params = %{
              title: body["Title"],
              imdb_id: body["imdbID"],
              image: body["Poster"],
            }
            # look up the show in database
            case Repo.get_by(Show, title: params.title) do
              nil -> %Show{} # build struct if doesn't exist
              show -> show
            end
            |> Show.changeset(params) # build changeset with struct and new params
            |> Repo.insert_or_update
            |> case do
              {:ok, show} -> fetch_seasons(show: show, total_seasons: total_seasons)
              _ -> IO.puts "Failed to create show #{params.title}"
            end
          _ -> IO.puts "Probably no seasons"
        end
      _ -> IO.puts "Something went wrong"
    end
  end

  def fetch_seasons(show: show, total_seasons: total_seasons) do
    Enum.each 1..total_seasons, fn i ->
      query_url = "#{@base_url}?t=#{show.imdb_id}&Season=#{i}&apikey=#{@api_key}"
      case HTTPoison.get query_url do
        {:ok, result} -> parse_and_create_season(show: show, season_result: result, season_number: i)
        {:error, reason} -> IO.puts("Failed to retrieve season #{i} for #{show.title}: #{reason}")
      end
    end
  end

  def parse_and_create_season(show: show, season_result: season_result, season_number: season_number) do
    case Poison.decode(season_result.body) do
      {:ok, body} ->
        params = %{
          number:  season_number,
          show_id: show.id
        }
        query = from s in Season,
                join: sh in Show, on: sh.id == s.show_id,
                where: s.show_id == ^show.id,
                where: s.number == ^season_number,
                select: s
        case Repo.one(query) do
          nil -> %Season{}
          season -> season
        end
        |> Season.changeset(params)
        |> Repo.insert_or_update
        |> case do
          {:ok, season} ->
            for episode_result <- body["Episodes"] do
              parse_and_create_episode(season: season, episode_result: episode_result)
            end
          _ -> IO.puts "Creating season failed"
        end
      {:error, reason} -> IO.puts(reason)
    end
  end

  def parse_and_create_episode(season: season, episode_result: episode_result) do
    params = %{
      imdb_rating: episode_result["imdbRating"],
      title:       episode_result["Title"],
      number:      episode_result["Episode"],
      imdb_id:     episode_result["imdbID"],
      season_id:   season.id,
    }

    query = from e in Episode,
            join: s in Season, on: e.season_id == ^season.id,
            where: e.number == ^params.number,
            select: e

    case query |> first |> Repo.one do
      nil -> %Episode{}
      episode -> episode
    end
    |> Episode.changeset(params)
    |> Repo.insert_or_update
  end

end
