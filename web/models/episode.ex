defmodule Wep.Episode do
  use Wep.Web, :model

  alias Wep.Season
  alias Wep.Question

  schema "episodes" do
    field :title, :string
    field :number, :integer
    field :imdb_id, :string
    belongs_to :season, Season
    has_many :questions, Question

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :number, :imdb_id, :season_id])
    |> cast_assoc(:season)
    |> validate_required([:title, :number, :imdb_id])
  end
end
