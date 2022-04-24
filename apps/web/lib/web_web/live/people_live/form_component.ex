defmodule WebWeb.PeopleLive.FormComponent do
  use WebWeb, :live_component

  def update(%{person: person} = assigns, socket) do
    changeset = People.change_person(person)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def handle_event("validate", %{"person" => person_params}, socket) do
    changeset =
      socket.assigns.person
      |> People.change_person(person_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"person" => person_params}, socket) do
    save_person(socket, socket.assigns.action, person_params)
  end

  defp save_person(socket, :edit, person_params) do
    person_params = handle_date(person_params)

    case People.update_person(socket.assigns.person.id, person_params) do
      {:ok, _person} ->
        {:noreply,
         socket
         |> put_flash(:info, "Person updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_person(socket, :new, person_params) do
    person_params = handle_date(person_params)

    case People.create_person(person_params) |> IO.inspect() do
      {:ok, _person} ->
        {:noreply,
         socket
         |> put_flash(:info, "Person created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp handle_date(
         %{"birthdate" => birthdate} = person_params
       ) do
    %{person_params | "birthdate" => Date.from_iso8601!(birthdate)}
  end

  # def update_changeset(%{assigns: %{changeset: changeset}} = socket, key, value) do
  #   socket
  #   |> assign(:changeset, Ecto.Changeset.put_change(changeset, key, value))
  # end
end



# <%= label f, :birthdate %>
# <%= date_select f, :birthdate, year: [options: 1923..2004], month: [options: [
#       {"January", "01"},
#       {"February", "02"},
#       {"March", "03"},
#       {"April", "04"},
#       {"May", "05"},
#       {"June", "06"},
#       {"July", "07"},
#       {"August", "08"},
#       {"September", "09"},
#       {"October", "10"},
#       {"November", "11"},
#       {"December", "12"},
#   ]] %>
# <%= error_tag f, :birthdate %>
