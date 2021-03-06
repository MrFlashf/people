defmodule Database.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Database.SQL.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Repo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
