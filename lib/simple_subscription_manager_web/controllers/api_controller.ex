defmodule SimpleSubscriptionManagerWeb.ApiController do
  use SimpleSubscriptionManagerWeb, :controller
  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Subscriptions

  # action_fallback SimpleSubscriptionManagerWeb.FallbackController


  # 登録情報を利用可能なユーザの人数と全体の割合を返す
  def index(conn, _params) do
    available_user = %{num_of_user: Subscribes.available_counter(), percent: Subscribes.available_percent()}
    render(conn, "index.json", available_user: available_user)
  end


  # サブスクーラーに登録されているサービスのリストを返す
  def index_service(conn, _params) do
    service_list = Subscriptions.list_subscriptions
    render(conn, "index.json", service_list: service_list)
  end


  # サブスクーラーに登録されているジャンルのリストを返す
  def index_genre(conn, _params) do
    genre_list = Subscriptions.list_genres
    render(conn, "index.json", genre_list: genre_list)
  end

  ## サービスランキングを取得

  # サブスクーラーに登録されたサービスのランキングを返す
  def index_service_ranking(conn, _params) do
    service_ranking = Subscribes.get_subscribes_ranking
    render(conn, "index.json", service_ranking: service_ranking)
  end


  # 性別別のサブスクーラーに登録されたサービスのランキングを返す
  def index_service_ranking_by_gender(conn, %{"gender" => gender}) do
    service_ranking = Subscribes.get_subscribes_ranking(gender)
    render(conn, "index.json", service_ranking_by_gender: service_ranking)
  end

  # 年代別のサブスクーラーに登録されたサービスのランキングを返す
  def index_service_ranking_by_age(conn, %{"age" => age}) do
    service_ranking = Subscribes.get_subscribes_ranking(0, age)
    render(conn, "index.json", service_ranking_by_age: service_ranking)
  end

  # 性別別&年代別のサブスクーラーに登録されたサービスのランキングを返す
  def index_service_ranking_by_gender_and_age(conn, %{"gender" => gender, "age" => age}) do
    service_ranking = Subscribes.get_subscribes_ranking(gender, age)
    render(conn, "index.json", service_ranking_by_gender_and_age: service_ranking)
  end

  ## サービスジャンルランキングを取得

  # サブスクーラーに登録されたサービスジャンルのランキングを返す
  def index_genre_ranking(conn, _params) do
    genre_ranking = Subscribes.get_genres_ranking
    render(conn, "index.json", genre_ranking: genre_ranking)
  end

  # 性別別のサブスクーラーに登録されたサービスジャンルのランキングを返す
  def index_genre_ranking_by_gender(conn, %{"gender" => gender}) do
    genre_ranking = Subscribes.get_genres_ranking(gender)
    render(conn, "index.json", genre_ranking_by_gender: genre_ranking)
  end

  # 年代別のサブスクーラーに登録されたサービスジャンルのランキングを返す
  def index_genre_ranking_by_age(conn, %{"age" => age}) do
    genre_ranking = Subscribes.get_genres_ranking(0, age)
    render(conn, "index.json", genre_ranking_by_age: genre_ranking)
  end

  # 性別別&年代別のサブスクーラーに登録されたサービスジャンルのランキングを返す
  def index_genre_ranking_by_gender_and_age(conn, %{"gender" => gender, "age" => age}) do
    genre_ranking = Subscribes.get_genres_ranking(gender, age)
    render(conn, "index.json", genre_ranking_by_gender_and_age: genre_ranking)
  end
end
