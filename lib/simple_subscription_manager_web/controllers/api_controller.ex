defmodule SimpleSubscriptionManagerWeb.ApiController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManager.Subscribes

  # action_fallback SimpleSubscriptionManagerWeb.FallbackController

  @doc """
  登録情報を利用可能なユーザの人数と全体の割合を返す
  """
  def index(conn, _params) do
    available_user = %{num_of_user: Subscribes.available_counter(), percent: Subscribes.available_percent() * 100.0}
    render(conn, "index.json", available_user: available_user)
  end
end
