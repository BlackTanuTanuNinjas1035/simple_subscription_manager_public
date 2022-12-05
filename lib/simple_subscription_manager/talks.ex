defmodule SimpleSubscriptionManager.Talks do
  alias SimpleSubscriptionManager.Talks.Talk
  alias SimpleSubscriptionManager.Repo
  import Ecto.Query

  def get_talk_list(index) do
    Talk
    |> where(index: ^index)
    |> Repo.all
  end

end
