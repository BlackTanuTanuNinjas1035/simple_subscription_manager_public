defmodule SimpleSubscriptionManagerWeb.AccountSessionController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Accounts
  alias SimpleSubscriptionManagerWeb.AccountAuth

  def new(conn, _params) do
    render(conn, "new.html", error_message: nil)
  end

  def create(conn, %{"account" => account_params}) do
    %{"email" => email, "password" => password} = account_params

    if account = Accounts.get_account_by_email_and_password(email, password) do
      AccountAuth.log_in_account(conn, account, account_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      render(conn, "new.html", error_message: "メールアドレスかパスワードの検証に失敗しました")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "ログアウトしました。")
    |> AccountAuth.log_out_account()
    |> case do
      {:ok, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, msg} ->
          conn
          |> put_flash(:info, msg)
          |> redirect(to: Routes.manager_path(conn, :index))
    end
  end
end
