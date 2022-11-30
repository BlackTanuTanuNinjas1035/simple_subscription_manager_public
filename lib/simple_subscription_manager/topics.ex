defmodule SimpleSubscriptionManager.Topics do
  alias SimpleSubscriptionManager.Repo
  alias SimpleSubscriptionManager.Topics.Topic
  import Ecto.Query

  def topic_list() do
    Repo.all Topic
  end

  def topic_list_by_genre(genre) do
    Topic |> where(genre: ^genre) |> Repo.all
  end

  def get_topic!(id), do: Repo.get!(Topic, id)

end
