defmodule SimpleSubscriptionManager.Util do

  alias SimpleSubscriptionManager.Converter

  @doc """
  主に日付計算用
  """
  def sub_month(x, y) do
    cond do
      x - y > 0 -> x-y
      x - y == 0 -> 12
      x - y < 0 -> 12+x-y
    end
  end

  def add_month(x, y) do
    rem(x+y, 12)
  end

  def adjust_month(x) do
    rem(x, 12)
  end

  def next_month_of_contract(year, month, day) do
    if month > 12 do
        Converter.convert!({year+1, adjust_month(month), day})
    else
        Converter.convert!({year, month, day})
    end
  end
end
