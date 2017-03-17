defmodule Wep.Repo.Migrations.CreateShow do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :title, :string
      add :imdb_id, :string

      timestamps()
    end

  end
end
