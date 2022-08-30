defmodule SimpleSubscriptionManagerWeb.PageController do
  use SimpleSubscriptionManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
