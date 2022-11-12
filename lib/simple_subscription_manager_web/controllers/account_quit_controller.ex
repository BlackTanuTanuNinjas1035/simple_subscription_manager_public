defmodule SimpleSubscriptionManagerWeb.AccountQuitController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManagerWeb.AccountAuth

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def quit(conn, _params) do
    conn
    |> put_flash(:info, "ログアウトしました。")
    |> AccountAuth.log_out_account()
    |> case do
      {:ok, _msg} ->
        case Acccounts.delete_account(conn.assigns[:current_account].id) do
          {:ok, msg} ->
            conn
            |> put_flash(:info, msg)
            |> redirect(to: Routes.page_path(conn, :index))
          {:error, msg} ->
            conn
            |> put_flash(:info, msg)
            |> redirect(to: Routes.manager_path(conn, :index))
        end
      {:error, msg} ->
          conn
          |> put_flash(:info, msg)
          |> redirect(to: Routes.manager_path(conn, :index))
      end
  end
end
