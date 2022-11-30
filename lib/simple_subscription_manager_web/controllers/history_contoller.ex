defmodule SimpleSubscriptionManagerWeb.HistoryController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Subscribes

  # ユーザの履歴を表示する
  def index(conn, _params) do

    account_id = conn.assigns[:current_account].id
    history_list = Subscribes.get_history(account_id)
    render(conn, "history.html", history_list: history_list)
  end

  def delete(conn, _params) do
    IO.inspect conn
  end
end
