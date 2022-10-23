defmodule SimpleSubscriptionManager.Subscriptions do
  alias SimpleSubscriptionManager.Subscriptions.Subscription
  alias SimpleSubscriptionManager.Repo
  import Ecto.Query

  @doc """
  サブスクリプションのリストを返す
  """
  def list_subscriptions() do
    Repo.all(Subscription)
    |> Repo.preload([:genre_alias])
  end

  @doc """
  引数genre_idで指定したジャンルのサブスクリプションのリストを返す
  """
  def list_subscriptions_by_id(genre_id) do

    query = from(s in Subscription, where: s.genre_id == ^genre_id)

    Repo.all(query)
    |> Repo.preload([:genre_alias])
  end
end
