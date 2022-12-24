defmodule SimpleSubscriptionManagerWeb.ManagerView do
  use SimpleSubscriptionManagerWeb, :view

  alias SimpleSubscriptionManager.Util

  def max_day(year, month) do
    Util.max_day(year, month)
  end
end
