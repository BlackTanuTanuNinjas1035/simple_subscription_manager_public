defmodule SimpleSubscriptionManager.Util do

  @doc """
  主に日付計算用
  """
  def calc_month(x, y) do
    cond do
      x - y > 0 -> x-y
      x - y == 0 -> 12
      x - y < 0 -> 12+x-y
    end
  end
end
