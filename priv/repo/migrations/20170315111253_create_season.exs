defmodule Wep.Repo.Migrations.CreateSeason do
  use Ecto.Migration

  def change do
    create table(:seasons) do
      add :number, :integer
      add :show_id, references(:shows, on_delete: :nothing)

      timestamps()
    end
    create index(:seasons, [:show_id])

  end
end
