defmodule NamesDB.Application do
  use Application

  # TODO: Maybe don't start Storage in tests
  def start(_type, _args) do
    children = [
      NamesDB.Storage
    ]

    opts = [strategy: :one_for_one, name: NamesDB.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
