defmodule SimpleSubscriptionManager.Subscriptions do
  alias SimpleSubscriptionManager.Subscriptions.Subscription
  alias SimpleSubscriptionManager.Repo

  def list_subscriptions() do
    Repo.all(Subscription)
    |> Repo.preload([:genre_alias])
  end
end
