defmodule SimpleSubscriptionManagerWeb.AccountQuitController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManagerWeb.AccountAuth

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def quit(conn, _params) do
    conn
    |> put_flash(:info, "ログアウトしました。")
    |> AccountAuth.delete_account()
    |> case do
      {:ok, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, msg} ->
          conn
          |> put_flash(:info, msg)
          |> redirect(to: Routes.manager_path(conn, :index))
      end
  end
end
