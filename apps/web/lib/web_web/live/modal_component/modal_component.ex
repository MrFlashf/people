defmodule WebWeb.ModalComponent do
  use WebWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, state: "CLOSED")}
  end

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
    }
  end

  def handle_event("open", _, socket) do
    {:noreply, assign(socket, :state, "OPEN")}
  end

  def handle_event("close", _, socket) do
    {:noreply, assign(socket, :state, "CLOSED")}
  end
 end
