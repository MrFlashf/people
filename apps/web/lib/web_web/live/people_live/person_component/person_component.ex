defmodule WebWeb.People.PersonComponent do
  use WebWeb, :live_component

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:show_details, false)}
  end

  def handle_event("toggle_details", _, %{assigns: %{show_details: show_details}} = socket) do
    {:noreply, assign(socket, :show_details, !show_details)}
  end


end
