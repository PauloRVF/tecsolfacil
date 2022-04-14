# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tecsolfacil, Tecsolfacil.Accounts.Guardian,
  issuer: "tecsolfacil",
  secret_key: "Dk+Jnh9olD/RXZaIWrJR++xzSLgALS1OjEjRH3FaUAg5d+vanlquQms3SalL237n"

config :swoosh, :api_client, false
config :tecsolfacil, Tecsolfacil.Mailer, adapter: Swoosh.Adapters.Local

config :tecsolfacil, Oban,
  repo: Tecsolfacil.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

config :tecsolfacil,
  cepws_adapter: Tecsolfacil.CepWs.Adapters.ViaCep

config :tecsolfacil,
  ecto_repos: [Tecsolfacil.Repo]

# Configures the endpoint
config :tecsolfacil, TecsolfacilWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TecsolfacilWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Tecsolfacil.PubSub,
  live_view: [signing_salt: "6aPkuNnF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :swoosh, serve_mailbox: true, preview_port: 4001
