defmodule SimpleSubscriptionManagerWeb.ApiView do
  use SimpleSubscriptionManagerWeb, :view
  alias SimpleSubscriptionManagerWeb.ApiView

  def render("index.json", %{available_user: available_user}) do
    render_one(available_user, ApiView, "available_user.json")
  end

  def render("available_user.json", %{api: available_user}) do
    %{
      point: available_user.point,
      raito: available_user.ratio
    }
  end
end
