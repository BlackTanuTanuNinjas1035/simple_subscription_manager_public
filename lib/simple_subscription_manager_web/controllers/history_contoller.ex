defmodule SimpleSubscriptionManagerWeb.HistoryController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Historys

  # ユーザの履歴を表示する
  def index(conn, _params) do

    account_id = conn.assigns[:current_account].id

    render(conn, "history.html",
    history_month_1: Historys.get_history(account_id, 1),
    history_month_2: Historys.get_history(account_id, 2),
    history_month_3: Historys.get_history(account_id, 3),
    history_month_4: Historys.get_history(account_id, 4),
    history_month_5: Historys.get_history(account_id, 5),
    history_month_6: Historys.get_history(account_id, 6),
    history_month_7: Historys.get_history(account_id, 7),
    history_month_8: Historys.get_history(account_id, 8),
    history_month_9: Historys.get_history(account_id, 9),
    history_month_10: Historys.get_history(account_id, 10),
    history_month_11: Historys.get_history(account_id, 11),
    history_month_12: Historys.get_history(account_id, 12)
      )
  end

  def delete(conn, _params) do
    IO.inspect conn
  end
end
