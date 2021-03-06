use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todone, TodoneWeb.Endpoint,
  http: [port: 4001],
  server: true

config :todone, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :todone, Todone.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "todone_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  timeout: 60_000,
  ownership_timeout: :infinity
