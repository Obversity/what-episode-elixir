defmodule Wep.ShowView do
  use Wep.Web, :view

  def render("index.json", %{shows: shows}) do
    shows
  end

  # def render("show.json", %{sh: sh}) do
  #   %{data: render_one(sh, Wep.ShowView, "show.json")}
  # end

  def render("show.json", %{sh: sh}) do
    %{id: sh.id,
      title: sh.title,
      imdb_id: sh.imdb_id,
      seasons: render_many(sh.seasons, Wep.SeasonView, "season.json")
    }
  end

  def render("not_found.json", %{ message: message }) do
    %{errors: [message]}
  end
end
