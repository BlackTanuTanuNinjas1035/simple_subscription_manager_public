defmodule SimpleSubscriptionManagerWeb.ManagerController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Subscribes.Subscribe

  def index(conn, _params) do
    subscribes = Subscribes.list_subscribe()
    changeset = Subscribe.changeset(%Subscribe{}, %{})
    conn
    |> render("index.html", subscribes: subscribes, changeset: changeset)
  end
end
