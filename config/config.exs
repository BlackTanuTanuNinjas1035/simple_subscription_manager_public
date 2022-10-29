# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :simple_subscription_manager,
  ecto_repos: [SimpleSubscriptionManager.Repo]

# Configures the endpoint
config :simple_subscription_manager, SimpleSubscriptionManagerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SimpleSubscriptionManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SimpleSubscriptionManager.PubSub,
  live_view: [signing_salt: "C6OXGaWM"]

# ローカル環境用
config :simple_subscription_manager, SimpleSubscriptionManager.Mailer, adapter: Swoosh.Adapters.Local
# 本番環境用
config :swoosh, :api_client, Swoosh.ApiClient.Local

# 本番環境用
# config :simple_subscription_manager, SimpleSubscriptionManager.Mailer,
#   adapter: Swoosh.Adapters.Sendgrid,
#   api_key: "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"

# 本番環境用
# config :swoosh, :api_client, Swoosh.ApiClient.Hackney

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
