defmodule Wep.Repo.Migrations.CreateEpisode do
  use Ecto.Migration

  def change do
    create table(:episodes) do
      add :title, :string
      add :number, :integer
      add :imdb_id, :string
      add :season_id, references(:seasons, on_delete: :nothing)

      timestamps()
    end
    create index(:episodes, [:season_id])

  end
end
