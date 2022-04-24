# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :database, Database.SQL.Repo,
  database: "database_repo",
  username: "postgres",
  password: "postgrd",
  hostname: "localhost"

config :database, ecto_repos: [Database.SQL.Repo]
config :names_db, :names_db_api, NamesDBImpl
config :people, :names_db_api, NamesDBImpl
config :database, :repo, Database.SQL
config :phoenix, json_library: Jason

# Configures the endpoint
config :web, WebWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: WebWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Web.PubSub,
  live_view: [signing_salt: "GGTOmni0"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

  config :tailwind, version: "3.0.24", default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/web/assets", __DIR__)
  ]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{config_env()}.exs"
