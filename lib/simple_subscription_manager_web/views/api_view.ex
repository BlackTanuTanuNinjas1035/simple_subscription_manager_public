defmodule SimpleSubscriptionManagerWeb.ApiView do
  use SimpleSubscriptionManagerWeb, :view
  alias SimpleSubscriptionManagerWeb.ApiView

  # 登録情報を利用可能なユーザの人数と全体の割合を返す
  def render("index.json", %{available_user: available_user}) do
    render_one(available_user, ApiView, "available_user.json")
  end

  def render("available_user.json", %{api: available_user}) do
    %{
      num_of_user: available_user.num_of_user,
      percent: available_user.percent
    }
  end

  # サブスクーラーに登録されているサービスのリストを返す
  def render("index.json", %{service_list: service_list}) do
    render_many(service_list, ApiView, "service.json")
  end

  def render("service.json", %{api: service_list}) do
    %{
      id: service_list.id,
      name: service_list.name,
      price: service_list.price,
      description: service_list.description,
      genres: service_list.genre_alias.name,
    }
  end

  # サブスクーラーに登録されているジャンルのリストを返す
  def render("index.json", %{genre_list: genre_list}) do
    render_many(genre_list, ApiView, "genre.json")
  end

  def render("genre.json", %{api: genre_list}) do
    %{
      id: genre_list.id,
      name: genre_list.name,
    }
  end

  # 登録されたサービスのランキングを返す
  def render("index.json", %{service_ranking: service_ranking}) do
    render_many(service_ranking, ApiView, "service_ranking.json")
  end

  def render("service_ranking.json", %{api: service_ranking}) do
    %{
      name: Enum.at(service_ranking, 0),
      genre: Enum.at(service_ranking, 1),
      point: Enum.at(service_ranking, 2),
      percent: Enum.at(service_ranking, 3),
    }
  end
end
