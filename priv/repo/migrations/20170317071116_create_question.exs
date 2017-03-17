defmodule Wep.Repo.Migrations.CreateQuestion do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :bit, :string
      add :flag_count, :integer
      add :episode_id, references(:episodes, on_delete: :nothing)

      timestamps()
    end
    create index(:questions, [:episode_id])

  end
end
