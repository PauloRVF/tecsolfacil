import Config

config :tecsolfacil,
  cepws_adapter: Tecsolfacil.CepWs.Adapters.Mock

#config :tecsolfacil, Oban, testing: :inline

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tecsolfacil, Tecsolfacil.Repo,
  username: "postgres",
  password: "postgres",
  database: "tecsolfacil_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tecsolfacil, TecsolfacilWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xwmAJ6INhBM8U2/wtYrw0xPYAWxtSW9i6R1rqVylEgYEacFoTfy1VyElEHA7X0UF",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
