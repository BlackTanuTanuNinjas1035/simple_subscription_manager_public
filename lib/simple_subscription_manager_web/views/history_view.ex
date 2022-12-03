defmodule SimpleSubscriptionManagerWeb.HistoryView do
  use SimpleSubscriptionManagerWeb, :view

  def month(month) do
    today = Date.utc_today()
    today.month - month
  end

  def previous_month(previous) do
    x = Date.utc_today().month - previous
    cond do
      x < 0 -> 12-x
      x == 0 -> 12
      x > 0 -> x
    end
  end
end
