defmodule Wep.Question do
  use Wep.Web, :model

  schema "questions" do
    field :bit, :string
    field :flag_count, :integer
    belongs_to :episode, Wep.Episode

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:bit, :flag_count, :episode_id])
    |> cast_assoc(:episode)
    |> validate_required([:bit, :episode_id])
  end
end
