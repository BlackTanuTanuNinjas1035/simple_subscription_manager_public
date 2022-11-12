defmodule SimpleSubscriptionManagerWeb.AccountQuitController do
  use SimpleSubscriptionManagerWeb, :controller

  # alias SimpleSubscriptionManager.Accounts
  # alias SimpleSubscriptionManagerWeb.AccountAuth

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def quit(conn, _params) do
    conn
    |> put_flash(:info, "ログアウトしました。")
    |> AccountAuth.log_out_account()

    Acccounts.delete_account(conn.assigns[:current_account].id)
  end
end
