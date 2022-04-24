defmodule People.Person do
  @type t :: %__MODULE__{
          name: String.t(),
          surname: String.t(),
          sex: :male | :female,
          birthdate: any()
        }

  defstruct ~w(name surname sex birthdate)a
end
