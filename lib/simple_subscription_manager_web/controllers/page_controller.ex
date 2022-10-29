defmodule SimpleSubscriptionManagerWeb.PageController do
  use SimpleSubscriptionManagerWeb, :controller


  def index(conn, _params) do
    IO.inspect(conn.assigns.current_account)
    render(conn, "index.html")
  end

  def help(conn, _params) do
    render(conn, "help.html")
  end

  def stat(conn, _params) do
    # 回答を得られた割合を取得
    number_of_ans = SimpleSubscriptionManager.Subscribes.available_percent()
    # 各サブスクリプションの登録数を表示
    subscription_counter = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking()
    subscription_counter_in_male = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(1)
    subscription_counter_in_female = SimpleSubscriptionManager.Subscribes.get_subscribes_ranking(2)

    # # リストの中身がタプルになっているので、リストに変更
    # subscription_counter = Enum.map subscription_counter_tuple, &Tuple.to_list/1
    # そして登録数の降順にソート
    # subscription_counter_sorted =  subscription_counter |> Enum.sort_by fn x -> elem x, 1 end , :desc

    # Subscription |> where name: "AbemaTV プレミア"
    render(conn, "stat.html", number_of_ans: number_of_ans, subscription_counter: subscription_counter, subscription_counter_in_male: subscription_counter_in_male, subscription_counter_in_female: subscription_counter_in_female)
  end
end
