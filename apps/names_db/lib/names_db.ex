defmodule NamesDB do
  @doc """
  Returns list of 100 most popular names and surnames both females' and males'.
  """
  @callback get_names :: %{
              male_names: list(String.t()),
              male_surnames: list(String.t()),
              female_names: list(String.t()),
              female_surnames: list(String.t())
            }

  def load, do: Application.fetch_env!(:names_db, :names_db_api)
end

defmodule NamesDBImpl do
  @behaviour NamesDB

  alias NamesDB.Storage

  def get_names, do: Storage.get_names_and_surnames()
end
