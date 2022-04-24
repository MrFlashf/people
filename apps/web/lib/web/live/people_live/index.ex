defmodule Web.PeopleLive.Index do
  use Web, :live_view

  alias Web.People.PersonComponent
  alias Database.SQL.Person

  def mount(_params, _, socket) do
    people = People.fetch_people([])

    {:ok,
     socket
     |> assign(:people, people)
     |> assign(:current_filters, %{})}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    People.remove_person(id)

    {:noreply, assign(socket, :people, People.fetch_people([]))}
  end

  def handle_event("generate_people", _, socket) do
    People.seed_people()

    {:noreply, assign(socket, :people, People.fetch_people([]))}
  end

  def handle_event(
        "filters_added",
        filters,
        socket
      ) do
    {:noreply,
     socket
     |> assign(:people, People.fetch_people(filters))}
  end

  def handle_event(
        "apply_filters",
        filters,
        socket
      ) do
    {:noreply,
     socket
     |> assign(:people, People.fetch_people(filters))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Person")
    |> assign(:person, People.get_person!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Person")
    |> assign(:person, %Person{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:person, nil)
  end
end
