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
    number_of_ans = SimpleSubscriptionManager.Subscribes.anser_counter()
    render(conn, "stat.html", number_of_ans: number_of_ans)
  end
end
