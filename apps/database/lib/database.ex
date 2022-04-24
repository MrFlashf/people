defmodule Database do
  alias Database.SQL.Person

  @callback fetch_people(filters :: map()) :: list(Person.t())

  @doc """
  Saves list of people to a data store. Requires a list of maps with people data type.
  """
  @callback batch_insert_people(people :: list(map())) :: {integer(), nil}

  @doc """
  Removes all people entries from the data store.
  """
  @callback remove_people() :: :ok

  @callback remove_person(person_id :: integer()) :: {:ok, Person.t()}

  @callback create_person(params :: map()) :: {:ok, Person.t()}

  @callback update_person(person_id :: integer(), params :: map()) :: {:ok, Person.t()}

  @callback get_person!(person_id :: integer()) :: Person.t()

  @doc """
  So this one is quite an issue.

  The idea behind this separated Database app was to have an option to switch easily between different types of databases.
  The client (in this case People app) just calls on an interface (behaviour) and gets the data, does not care at all whether this data came from postgres, DynamoDB, graph database or your own DB implementation written in C and rust.
  However, since LiveView forms are so tightly cooupled with Ecto changesets, it would require a big amount of work to make an implementation that doesn't use these changesets.

  So now I need to add to this behaviour a function that generates Ecto changeset, thus coupling it to Ecto entirely (and what comes with it - to SQL db).

  I could of course use Ecto changesets just as an "exported" structure and map it for other libraries, but it all seems to be pointless at this stage.
  """
  @callback change_person(person :: Person.t(), params :: map()) :: Ecto.Changeset.t()

  def load, do: Application.fetch_env!(:database, :repo)
end

defmodule DatabaseStub do
  alias Database.SQL.Person
  @behaviour Database

  def batch_insert_people(people), do: {length(people), nil}

  def fetch_people(_filters), do: []

  def remove_people(), do: :ok

  def remove_person(_person_id), do: {:ok, %Person{}}

  def create_person(_params), do: {:ok, %Person{}}

  def update_person(_person_id, _params), do: {:ok, %Person{}}

  def get_person!(_person_id), do: %Person{}

  def change_person(person, params), do: Person.changeset(person, params)
end
