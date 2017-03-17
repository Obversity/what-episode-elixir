defmodule Wep.Season do
  use Wep.Web, :model

  alias Wep.Show
  alias Wep.Episode

  schema "seasons" do
    field :number, :integer
    belongs_to :show, Show
    has_many :episodes, Episode

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number, :show_id])
    |> cast_assoc(:show)
    |> validate_required([:number])
  end
end
