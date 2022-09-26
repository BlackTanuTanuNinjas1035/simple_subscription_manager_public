defmodule SimpleSubscriptionManagerWeb.PageController do
  use SimpleSubscriptionManagerWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns.current_account)
    render(conn, "index.html")
  end

  def help(conn, _params) do
    render(conn, "help.html")
  end
end
