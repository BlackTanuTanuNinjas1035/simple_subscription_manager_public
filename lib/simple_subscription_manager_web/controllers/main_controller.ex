defmodule SimpleSubscriptionManagerWeb.ManagerController do
  use SimpleSubscriptionManagerWeb, :controller

  def home(conn, _prams) do
    render(conn, "index.html")
  end
end
