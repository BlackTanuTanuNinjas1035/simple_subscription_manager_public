defmodule SimpleSubscriptionManagerWeb.HistoryController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.History

  # ユーザの履歴を表示する
  def index(conn, _params) do

    account_id = conn.assigns[:current_account].id

    render(conn, "history.html",
    history_month_1: History.get_history(account_id, 1),
    history_month_2: History.get_history(account_id, 2),
    history_month_3: History.get_history(account_id, 3),
    history_month_4: History.get_history(account_id, 4),
    history_month_5: History.get_history(account_id, 5),
    history_month_6: History.get_history(account_id, 6),
    history_month_7: History.get_history(account_id, 7),
    history_month_8: History.get_history(account_id, 8),
    history_month_9: History.get_history(account_id, 9),
    history_month_10: History.get_history(account_id, 10),
    history_month_11: History.get_history(account_id, 11),
    history_month_12: History.get_history(account_id, 12)
      )
  end

  def delete(conn, _params) do
    IO.inspect conn
  end
end
