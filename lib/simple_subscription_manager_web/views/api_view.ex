defmodule SimpleSubscriptionManagerWeb.ApiView do
  use SimpleSubscriptionManagerWeb, :view

  def render("index.json", point, ratio) do
    %{
      point: point,
      ratio: ratio
    }
  end
end
