defmodule SimpleSubscriptionManagerWeb.ApiController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManager.Subscribes

  # action_fallback SimpleSubscriptionManagerWeb.FallbackController

  def index(conn, _params) do
    available_user = %{point: Subscribes.answer_counter(), ratio: Subscribes.answer_counter()}
    render(conn, "index.json", available_user: available_user)
  end
end
