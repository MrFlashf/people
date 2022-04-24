defmodule People do
  alias Database.SQL.Person

  @database Database.load()
  @names_db NamesDB.load()
  @year_in_milliseconds :timer.hours(365 * 24)

  @doc """
  Generates a list of people and saves it to the Database.

  By default generates male and female persons with 50/50 proportions, but this can be customized with `male_proportions` argument - for example, if we need a 30/70 male/female ratio, substitute `male_propotions` with `30`.
  """
  def seed_people(number_of_people \\ 100, male_proportions \\ 50) do
    names = @names_db.get_names()

    people =
      for _i <- 1..number_of_people do
        generate_person(names, male_proportions)
      end

    @database.remove_people()
    @database.batch_insert_people(people)

    people
  end

  def fetch_people(filters) do
    @database.fetch_people(filters)
  end

  def get_person!(person_id), do: @database.get_person!(person_id)

  def create_person(params), do: @database.create_person(params)

  def update_person(person_id, params), do: @database.update_person(person_id, params)

  def remove_person(person_id), do: @database.remove_person(person_id)

  def change_person(person, params \\ %{}), do: @database.change_person(person, params)

  defp generate_person(names, male_proportions),
    do: if(sex(male_proportions) == :male, do: generate_male(names), else: generate_female(names))

  defp generate_male(%{
         male_names: names,
         male_surnames: surnames
       }) do
    %{
      name: Enum.random(names),
      surname: Enum.random(surnames),
      sex: :male,
      birthdate: generate_birthdate()
    }
  end

  defp generate_female(%{
         female_names: names,
         female_surnames: surnames
       }) do
    %{
      name: Enum.random(names),
      surname: Enum.random(surnames),
      sex: :female,
      birthdate: generate_birthdate()
    }
  end

  defp generate_birthdate do
    age = :rand.uniform(81) + 18

    Date.utc_today()
    |> Date.add(-age * 365)
  end

  defp sex(male_proportions) do
    random_value = :rand.uniform(100)

    if random_value <= male_proportions, do: :male, else: :female
  end
end
