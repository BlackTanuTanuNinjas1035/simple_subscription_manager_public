defmodule SimpleSubscriptionManager.Repo do
  use Ecto.Repo,
    otp_app: :simple_subscription_manager,
    adapter: Ecto.Adapters.Postgres
end
