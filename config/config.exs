# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :flights_api,
  ecto_repos: [FlightsApi.Repo]

# Configures the endpoint
config :flights_api, FlightsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6KK9o+pTiWdGTJ7qId2VAn5GUADFcGpBJwi/h0wr3Ds8GZz5HyjKzuxPqyEt86XJ",
  render_errors: [view: FlightsApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FlightsApi.PubSub,
  live_view: [signing_salt: "TYAX9e+P"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
