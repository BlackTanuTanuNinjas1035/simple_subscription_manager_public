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

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# 古いのでコメントアウト
# # Configures Elixir's Logger
# config :logger, :console,
#   format: "$time $metadata[$level] $message\n",
#   metadata: [:request_id]

config :logger,
  # :error_log というキーに対して、LoggerFileBackend を紐付けます
  backends: [{LoggerFileBackend, :error_log}]

# :error_log の設定
config :logger, :error_log,
  # ログの保存先, ファイル名
  path: "../log/error.log",
  # 対象とするレベル
  level: :error,
  # ログフォーマット
  format: "$time $metadata[$level] $message\n",
  # メタデータの要素
  metadata: [:request_id]

config :logger,
  # :error_log というキーに対して、LoggerFileBackend を紐付けます
  backends: [{LoggerFileBackend, :info_log}]

# :info_log の設定
config :logger, :info_log,
  format: "$date $time $metadata[$level] $message\n",
  path: "../log/info.log",
  level: :info,
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :simple_subscription_manager, SimpleSubscriptionManager.Scheduler,
  jobs: [
    {"0 0 * * *", {SimpleSubscriptionManager.Scheduler, :check_date_of_payment, []}},
    {"0 0 * * *", {SimpleSubscriptionManager.Scheduler, :check_continue_subscription, []}},
    {"0 0 * * *", {SimpleSubscriptionManager.Logging, :mv_log, []}},
    {"0 0 1 * *", {SimpleSubscriptionManager.Logging, :to_archive, []}},
    {"0 0 * * *", {SimpleSubscriptionManager.Scheduler, :postgres_backup, []}},
    {"0 0 1 * *", {SimpleSubscriptionManager.Scheduler, :postgres_backup_tar, []}},
  ]
