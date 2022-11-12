defmodule SimpleSubscriptionManager.Subscribes.SubscribeNotifier do
  import Swoosh.Email
  use Swoosh.Mailer, otp_app: :simple_subscription_manager

  alias SimpleSubscriptionManager.Mailer

  @subscler_email "subscler14106@gmail.com"

  # メール送信機能
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"サブスクーラー システム Mail", @subscler_email})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  # 登録したサービスの支払日まで残り10日になったことを伝えるメール
  def deliver_date_of_payment(email, service, date) do
    deliver(email, "登録したサービスの支払日について", """

    このメールは、サブスクーラーをご利用されている方が登録されたサービスのうち、
    支払日が残り10日になったものがある場合に自動で送信されます。
    ==============================

    Hi #{email},

    YouのSubscribeした#{service}の利用料金をPayする日まで、残り10日になったぜ！


    残り10日までしっかりとお財布の中身を確認しておいてくれよな！

    支払い日: #{date}
    ==============================
    """)
  end

  @subscler_email "subscler14106@gmail.com"

  # メール送信機能
  defp deliver_to_subscler(name, from, subject, body) do
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
    deliver_to_subscler(name, email, "サービスの登録申請", """

    ==============================

    name: #{name}, email: #{email} から

    サービス名: #{service}
    プラン名  : #{plan}
    """)
  end
end
