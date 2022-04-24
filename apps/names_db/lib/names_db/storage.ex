defmodule NamesDB.Storage do
  use GenServer

  alias NamesDB.Client

  @name __MODULE__

  def start_link(_) do
    GenServer.start_link(@name, [], name: @name)
  end

  def male_names do
    GenServer.call(@name, :male_names)
  end

  def get_names_and_surnames do
    GenServer.call(@name, :get_all)
  end

  ### Callbacks ###

  def init(_) do
    send(self(), :fetch_data)

    {:ok, %{}}
  end

  def handle_info(:fetch_data, _state) do
    {:noreply,
     %{
       female_names: Client.female_names(),
       female_surnames: Client.female_surnames(),
       male_names: Client.male_names(),
       male_surnames: Client.male_surnames()
     }}
  end

  def handle_call(:get_all, _from, state), do: {:reply, state, state}
end
