defmodule SimpleSubscriptionManagerWeb.TopicController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Topics

  def index(conn, _params) do
    topic_list = Topics.topic_list()
    service_topic_list = Topics.topic_list_by_genre("サービスの追加")
    render(conn, "index.html", topic_list: topic_list, service_topic_list: service_topic_list)
  end

  def show(conn, %{"id" => id}) do
    IO.inspect conn
    topic = Topics.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end
end
