defmodule SimpleSubscriptionManagerWeb.FormController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Form.FormNotifier


  def form(conn, _params) do
    render(conn, "form.html")
  end

  def inquiry_form(conn, %{"genre" => genre, "text" => text }) do
    IO.puts "conn"
    IO.inspect conn
    # IO.puts "params"
    # IO.inspect params
    current_account = conn.assigns.current_account
    FormNotifier.deliver_inquiry_mail(current_account.name, current_account.email,  genre, text)
    conn
    |> put_flash(:info, "フォームの送信に成功しました")
    |> redirect(to: Routes.manager_path(conn, :index))
  end
end
