defmodule Database.SQL.Person do
  use Database.SQL.Repo.Schema

  schema "people" do
    field :name, :string
    field :surname, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    field :birthdate, :date

    timestamps()
  end

  @fields ~w(name surname sex birthdate)a

  def changeset(%__MODULE__{} = struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
