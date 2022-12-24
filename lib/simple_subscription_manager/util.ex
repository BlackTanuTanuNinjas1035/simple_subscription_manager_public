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

  def max_day(year, month) do
    case month do
      1 -> 	31
      2 ->
        if Date.leap_year?(Date.new(year, 1, 1)) do
          28
        else
          29
        end
      3 ->	31
      4 ->	30
      5 ->	31
      6 ->	30
      7 ->	31
      8 ->	31
      9 ->	30
      10 ->	31
      11 ->	30
      12 ->	31
    end
  end

  def max_day_by_string(year, month) do
    case month do
      "1" -> 	"31"
      "2" ->
        if Date.leap_year?(Date.new(String.to_integer(year), 1, 1)) do
          "28"
        else
          "29"
        end
      "3" ->	"31"
      "4" ->	"30"
      "5" ->	"31"
      "6" ->	"30"
      "7" ->	"31"
      "8" ->	"31"
      "9" ->	"30"
      "10" ->	"31"
      "11" ->	"30"
      "12" ->	"31"
    end
  end
end
