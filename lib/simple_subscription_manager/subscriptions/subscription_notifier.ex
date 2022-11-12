defmodule SimpleSubscriptionManager.Subscriptions.SubscriptionNotifier do
  import Swoosh.Email
  use Swoosh.Mailer, otp_app: :simple_subscription_manager
  alias SimpleSubscriptionManager.Mailer

  @subscler_email "subscler14106@gmail.com"

  # メール送信機能
  defp deliver(name, from, subject, body) do
    email =
      new()
      |> to(@subscler_email)
      |> from({"#{name}からサービス登録申請", from})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  # ユーザがアプリ管理者に追加してほしいサービスを伝えるメール
  def deliver_additional_service(name, email, service, plan) do
    deliver(name, email, "サービスの登録申請", """

    ==============================

    name: #{name}, email: #{email} から

    サービス名: #{service}
    プラン名  : #{plan}
    """)
  end
end
