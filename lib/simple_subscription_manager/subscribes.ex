defmodule SimpleSubscriptionManager.Subscribes do
  alias SimpleSubscriptionManager.Subscribes.Subscribe
  alias SimpleSubscriptionManager.Repo

  def list_subscribe() do
    Repo.all(Subscribe)
    |> Repo.preload([:account_alias, :subscription_alias])
  end

end
