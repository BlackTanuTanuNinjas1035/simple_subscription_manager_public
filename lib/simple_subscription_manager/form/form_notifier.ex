defmodule SimpleSubscriptionManager.Form.FormNotifier do
  import Swoosh.Email
  use Swoosh.Mailer, otp_app: :simple_subscription_manager

  alias SimpleSubscriptionManager.Mailer

  @subscler_email "tanutanu@gmail.com"

  # サブスクーラー管理用メールへ送信する機能
  defp deliver_to_subscler(from, subject, body) do
    email =
      new()
      |> to(@subscler_email)
      |> from({subject, from})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  # ユーザがアプリ管理者に追加してほしいサービスを伝えるメール
  def deliver_inquiry_mail(name, email, genre, text) do
    subject = "#{genre}: by #{name}"
    deliver_to_subscler(email, subject, text)
  end
end
