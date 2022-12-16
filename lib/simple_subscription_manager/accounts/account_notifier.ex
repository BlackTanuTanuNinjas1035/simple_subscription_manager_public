defmodule SimpleSubscriptionManager.Accounts.AccountNotifier do
  import Swoosh.Email
  use Swoosh.Mailer, otp_app: :simple_subscription_manager

  alias SimpleSubscriptionManager.Mailer

  @subscler_email "subscler14106@gmail.com"
  # メール送信機能
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"サブスクーラー", @subscler_email})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to confirm account.
  """
  def deliver_confirmation_instructions(account, url) do
    deliver(account.email, "アカウント作成の確認", """

    　こんにちは、 #{account.email}　様
    サブスクリプションサービス管理Webアプリケーション「サブスクーラー」をご利用いただきありがとうございます。
    作成したアカウントは以下のURLで確認することができます。

    ==============================
    #{url}
    ==============================

    今後とも、サブスクーラーをよろしくお願いいたします。

    もしこのメール見覚えがない場合は無視してください。
    """)
  end

  @doc """
  Deliver instructions to reset a account password.
  パスワードをリセットする際に送信されるメール。
  """
  def deliver_reset_password_instructions(account, url) do
    deliver(account.email, "Reset password instructions", """


    　こんにちは、 #{account.email}　様

    登録したパスワードを変更されたい場合は以下のURLにお進みください。

    ==============================
    #{url}
    ==============================

    今後とも、サブスクーラーをよろしくお願いいたします。

    もしこのメール見覚えがない場合は無視してください。
    """)
  end

  @doc """
  Deliver instructions to update a account email.
  アカウントのEメールを変更する際に送信されるメール。
  """
  def deliver_update_email_instructions(account, url) do
    deliver(account.email, "メールアドレスの変更", """



    お世話になっております #{account.email}さま

    現在のメールアドレスの変更を確定するため以下のリンクにお進みください。

    ==============================
    #{url}
    ==============================

    今後とも、サブスクーラーをよろしくお願いいたします。

    もしこのメールに見覚えがない場合は無視してください。
    """)
  end
end
