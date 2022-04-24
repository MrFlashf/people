defmodule Database.SQL.Repo do
  use Ecto.Repo,
    otp_app: :database,
    adapter: Ecto.Adapters.Postgres
end
