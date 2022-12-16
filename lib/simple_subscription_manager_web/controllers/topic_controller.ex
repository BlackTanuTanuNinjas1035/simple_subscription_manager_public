defmodule SimpleSubscriptionManagerWeb.TopicController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Topics

  def index(conn, _params) do
    service_add_topic_list = Topics.topic_list_by_genre("サービスの追加")
    service_update_topic_list = Topics.topic_list_by_genre("サービスの変更")
    function_add_topic_list = Topics.topic_list_by_genre("機能の追加")
    function_update_topic_list = Topics.topic_list_by_genre("機能の変更")
    bug_fixes_list = Topics.topic_list_by_genre("不具合の修正")
    etc_list = Topics.topic_list_by_genre("運営からのお知らせ")
    render(conn, "index.html",
      service_add_topic_list: Enum.take(service_add_topic_list, 10),
      service_update_topic_list: Enum.take(service_update_topic_list, 10),
      function_add_topic_list: Enum.take(function_add_topic_list, 10),
      function_update_topic_list: Enum.take(function_update_topic_list, 10),
      bug_fixes_list: Enum.take(bug_fixes_list, 10),
      etc_list: Enum.take(etc_list, 10)
    )
  end

  def show(conn, %{"id" => id}) do
    IO.inspect conn
    topic = Topics.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end
end
