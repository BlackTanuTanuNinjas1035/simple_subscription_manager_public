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
      |> from({"サブスクーラー システム Mail", @subscler_email})
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
    deliver(account.email, "Confirmation instructions", """

    ==============================

    Hi #{account.email},

    You can confirm your account by visiting the URL below:

    #{url}

    If you didn't create an account with us, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to reset a account password.
  パスワードをリセットする際に送信されるメール。
  """
  def deliver_reset_password_instructions(account, url) do
    deliver(account.email, "Reset password instructions", """

    ==============================

    Hi #{account.email},

    You can reset your password by visiting the URL below:

    #{url}

    If you didn't request this change, please ignore this.

    ==============================
    """)
  end

  @doc """
  Deliver instructions to update a account email.
  アカウントのEメールを変更する際に送信されるメール。
  """
  def deliver_update_email_instructions(account, url) do
    deliver(account.email, "メールアドレスの変更", """

    ==============================

    お世話になっております #{account.email}さま

    メールアドレスの変更を確定するため以下のリンクに行ってください:

    #{url}

    もしこのメールに見覚えがない場合は無視してください。

    ==============================
    """)
  end
end
