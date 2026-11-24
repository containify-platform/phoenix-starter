defmodule PhoenixStarter.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :path, :string, null: false
      timestamps(type: :utc_datetime)
    end
  end
end
