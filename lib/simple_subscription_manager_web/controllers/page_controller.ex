defmodule SimpleSubscriptionManagerWeb.PageController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Talks

  def index(conn, _params) do
    IO.inspect(conn)
    render(conn, "index.html")
  end

  def help(conn, _params) do
    content_list = [
        {"導入部分", Talks.get_talk_list(0)},
        {"機能説明 その1: サブスク利用状況を可視化", Talks.get_talk_list(1)},
      ]
    render(conn, "help.html", content_list: content_list)
  end

  def stat(conn, _params) do
    # 回答を得られた割合を取得
    number_of_ans = SimpleSubscriptionManager.Subscribes.available_percent()
    # 各サブスクリプションの登録数を表示
    subscription_counter = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking()
    subscription_counter_by_age_0 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 0)
    subscription_counter_by_age_10 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 10)
    subscription_counter_by_age_20 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 20)
    subscription_counter_by_age_30 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 30)
    subscription_counter_by_age_40 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 40)
    subscription_counter_by_age_50 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 50)
    subscription_counter_by_age_60 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 60)
    subscription_counter_by_age_70 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(0, 70)
    genre_counter = SimpleSubscriptionManager.Subscribes.get_genres_ranking()
    genre_counter_by_age_0 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 0)
    genre_counter_by_age_10 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 10)
    genre_counter_by_age_20 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 20)
    genre_counter_by_age_30 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 30)
    genre_counter_by_age_40 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 40)
    genre_counter_by_age_50 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 50)
    genre_counter_by_age_60 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 60)
    genre_counter_by_age_70 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(0, 70)

    subscription_counter_in_male = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1)
    subscription_counter_in_male_by_age_0 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 0)
    subscription_counter_in_male_by_age_10 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 10)
    subscription_counter_in_male_by_age_20 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 20)
    subscription_counter_in_male_by_age_30 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 30)
    subscription_counter_in_male_by_age_40 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 40)
    subscription_counter_in_male_by_age_50 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 50)
    subscription_counter_in_male_by_age_60 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 60)
    subscription_counter_in_male_by_age_70 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1, 70)

    genre_counter_in_male = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1)
    genre_counter_in_male_by_age_0 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 0)
    genre_counter_in_male_by_age_10 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 10)
    genre_counter_in_male_by_age_20 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 20)
    genre_counter_in_male_by_age_30 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 30)
    genre_counter_in_male_by_age_40 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 40)
    genre_counter_in_male_by_age_50 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 50)
    genre_counter_in_male_by_age_60 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 60)
    genre_counter_in_male_by_age_70 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(1, 70)

    subscription_counter_in_female = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2)
    subscription_counter_in_female_by_age_0 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 0)
    subscription_counter_in_female_by_age_10 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 10)
    subscription_counter_in_female_by_age_20 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 20)
    subscription_counter_in_female_by_age_30 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 30)
    subscription_counter_in_female_by_age_40 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 40)
    subscription_counter_in_female_by_age_50 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 50)
    subscription_counter_in_female_by_age_60 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 60)
    subscription_counter_in_female_by_age_70 = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2, 70)

    genre_counter_in_female = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2)
    genre_counter_in_female_by_age_0 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 0)
    genre_counter_in_female_by_age_10 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 10)
    genre_counter_in_female_by_age_20 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 20)
    genre_counter_in_female_by_age_30 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 30)
    genre_counter_in_female_by_age_40 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 40)
    genre_counter_in_female_by_age_50 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 50)
    genre_counter_in_female_by_age_60 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 60)
    genre_counter_in_female_by_age_70 = SimpleSubscriptionManager.Subscribes.get_genres_ranking(2, 70)

    render(conn, "stat.html",
      number_of_ans: number_of_ans,
      subscription_counter: subscription_counter,
      subscription_counter_by_age_0: subscription_counter_by_age_0,
      subscription_counter_by_age_10: subscription_counter_by_age_10,
      subscription_counter_by_age_20: subscription_counter_by_age_20,
      subscription_counter_by_age_30: subscription_counter_by_age_30,
      subscription_counter_by_age_40: subscription_counter_by_age_40,
      subscription_counter_by_age_50: subscription_counter_by_age_50,
      subscription_counter_by_age_60: subscription_counter_by_age_60,
      subscription_counter_by_age_70: subscription_counter_by_age_70,
      subscription_counter_in_male: subscription_counter_in_male,
      subscription_counter_in_male_by_age_0: subscription_counter_in_male_by_age_0,
      subscription_counter_in_male_by_age_10: subscription_counter_in_male_by_age_10,
      subscription_counter_in_male_by_age_20: subscription_counter_in_male_by_age_20,
      subscription_counter_in_male_by_age_30: subscription_counter_in_male_by_age_30,
      subscription_counter_in_male_by_age_40: subscription_counter_in_male_by_age_40,
      subscription_counter_in_male_by_age_50: subscription_counter_in_male_by_age_50,
      subscription_counter_in_male_by_age_60: subscription_counter_in_male_by_age_60,
      subscription_counter_in_male_by_age_70: subscription_counter_in_male_by_age_70,
      subscription_counter_in_female: subscription_counter_in_female,
      subscription_counter_in_female_by_age_0: subscription_counter_in_female_by_age_0,
      subscription_counter_in_female_by_age_10: subscription_counter_in_female_by_age_10,
      subscription_counter_in_female_by_age_20: subscription_counter_in_female_by_age_20,
      subscription_counter_in_female_by_age_30: subscription_counter_in_female_by_age_30,
      subscription_counter_in_female_by_age_40: subscription_counter_in_female_by_age_40,
      subscription_counter_in_female_by_age_50: subscription_counter_in_female_by_age_50,
      subscription_counter_in_female_by_age_60: subscription_counter_in_female_by_age_60,
      subscription_counter_in_female_by_age_70: subscription_counter_in_female_by_age_70,
      genre_counter: genre_counter,
      genre_counter_by_age_0: genre_counter_by_age_0,
      genre_counter_by_age_10: genre_counter_by_age_10,
      genre_counter_by_age_20: genre_counter_by_age_20,
      genre_counter_by_age_30: genre_counter_by_age_30,
      genre_counter_by_age_40: genre_counter_by_age_40,
      genre_counter_by_age_50: genre_counter_by_age_50,
      genre_counter_by_age_60: genre_counter_by_age_60,
      genre_counter_by_age_70: genre_counter_by_age_70,
      genre_counter_in_male: genre_counter_in_male,
      genre_counter_in_male_by_age_0: genre_counter_in_male_by_age_0,
      genre_counter_in_male_by_age_10: genre_counter_in_male_by_age_10,
      genre_counter_in_male_by_age_20: genre_counter_in_male_by_age_20,
      genre_counter_in_male_by_age_30: genre_counter_in_male_by_age_30,
      genre_counter_in_male_by_age_40: genre_counter_in_male_by_age_40,
      genre_counter_in_male_by_age_50: genre_counter_in_male_by_age_50,
      genre_counter_in_male_by_age_60: genre_counter_in_male_by_age_60,
      genre_counter_in_male_by_age_70: genre_counter_in_male_by_age_70,
      genre_counter_in_female: genre_counter_in_female,
      genre_counter_in_female_by_age_0: genre_counter_in_female_by_age_0,
      genre_counter_in_female_by_age_10: genre_counter_in_female_by_age_10,
      genre_counter_in_female_by_age_20: genre_counter_in_female_by_age_20,
      genre_counter_in_female_by_age_30: genre_counter_in_female_by_age_30,
      genre_counter_in_female_by_age_40: genre_counter_in_female_by_age_40,
      genre_counter_in_female_by_age_50: genre_counter_in_female_by_age_50,
      genre_counter_in_female_by_age_60: genre_counter_in_female_by_age_60,
      genre_counter_in_female_by_age_70: genre_counter_in_female_by_age_70
    )
  end
end
