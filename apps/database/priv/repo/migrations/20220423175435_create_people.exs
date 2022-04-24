defmodule Database.SQL.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table("people") do
      add :name, :string
      add :surname, :string
      add :sex, :string
      add :birthdate, :date

      timestamps()
    end
  end
end
