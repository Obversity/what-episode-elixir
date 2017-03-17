defmodule Wep.Show do
  use Wep.Web, :model
  alias Wep.Repo
  alias Wep.OmdbFetcher

  alias Wep.Season

  schema "shows" do
    field :title, :string
    field :imdb_id, :string
    has_many :seasons, Season

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :imdb_id])
    |> validate_required([:title, :imdb_id])
  end

  def get_by_title(title) do
    query = from show in Wep.Show,
            where: ilike(show.title, ^"%#{title}%"),
            preload: [seasons: [episodes: :questions]],
            select: show

    case Repo.one(query) do
      nil ->
        OmdbFetcher.fetch(title)
        Repo.one(query)
      show -> show
    end
  end
end
