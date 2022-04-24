defmodule Database.SQL do
  @behaviour Database

  import Ecto.Query

  alias Database.SQL.Repo
  alias Database.SQL.Person

  def batch_insert_people(people) do
    people =
      Enum.map(people, fn person ->
        person
        |> Map.put(:inserted_at, DateTime.utc_now())
        |> Map.put(:updated_at, DateTime.utc_now())
      end)

    Repo.insert_all(Person, people)
  end

  def remove_people do
    Repo.delete_all(Person)
  end

  def fetch_people(filters) do
    Person
    |> filter_name(filters)
    |> filter_surname(filters)
    |> order_by([p], desc: p.inserted_at)
    |> Repo.all()
  end

  def remove_person(person_id) do
    person_id
    |> get_person!()
    |> Repo.delete()
  end

  def create_person(params) do
    %Person{}
    |> Person.changeset(params)
    |> Repo.insert()
  end

  def update_person(person_id, params) do
    person_id
    |> get_person!()
    |> Person.changeset(params)
    |> Repo.update()
  end

  def get_person!(person_id), do: Repo.get!(Person, person_id)

  def change_person(person, params), do: Person.changeset(person, params)

  defp filter_name(query, %{"name" => name}) do
    like_term = "%#{name}%"
    where(query, [p], ilike(p.name, ^like_term))
  end

  defp filter_name(query, _), do: query

  defp filter_surname(query, %{"surname" => surname}) do
    like_term = "%#{surname}%"
    where(query, [p], ilike(p.surname, ^like_term))
  end

  defp filter_surname(query, _), do: query
end
