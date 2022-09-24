defmodule SimpleSubscriptionManagerWeb.PageController do
  use SimpleSubscriptionManagerWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns.current_account)
    render(conn, "index.html")
  end
end
