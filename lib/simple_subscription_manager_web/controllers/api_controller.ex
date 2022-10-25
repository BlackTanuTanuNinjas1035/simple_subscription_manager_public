defmodule SimpleSubscriptionManagerWeb.ApiController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManagerWeb.Subscribes

  def index(conn, _params) do
    answer_counter = Subscribes.answer_counter()
    ratio = Subscribes.anser_counter()
    render(conn, "index.json", point: answer_counter, ratio: ratio)
  end
end
