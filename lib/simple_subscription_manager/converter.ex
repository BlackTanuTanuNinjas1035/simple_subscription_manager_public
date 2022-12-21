defmodule SimpleSubscriptionManager.Converter do

  @moduledoc """
  FormからのStringの値を変換
  """

  def convert!("true"), do: true
  def convert!("false"), do: false
  def convert!(%{"day" => day, "month" => month, "year" => year}) when is_integer(day), do: Date.new!(year, month, day)
  def convert!(%{"day" => day, "month" => month, "year" => year}) when is_binary(day) and is_integer(month) and is_binary(year), do: Date.new!(year, Integer.to_string(month), day)
  def convert!(%{"day" => day, "month" => month, "year" => year}), do: Date.new!(String.to_integer(year), String.to_integer(month), String.to_integer(day))

end
