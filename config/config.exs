# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todone,
  ecto_repos: [Todone.Repo]

# Configures the endpoint
config :todone, TodoneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QeTrTWhf4if/snjoy7jFOa86P9qk/Y9scH3A2+dT6xrqetzekXGDH/Q1OXoxl1us",
  render_errors: [view: TodoneWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Todone.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
