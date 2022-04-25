# People

## Requirements

- Elixir 1.13
- Erlang 24
- Running postgres instance

## Setup

- Download the repository
- Change postgres config in `config.exs` accordingly to your local instance
- `mix deps.get`
- `mix ecto.create && mix ecto.migrate`
- `cd apps/web && mix assets.deploy`

## Run the server

Run `iex -S mix phx.server` from app root to start phoenix server. Navigate to `localhost:4000/people` in your browser to enter the app.
