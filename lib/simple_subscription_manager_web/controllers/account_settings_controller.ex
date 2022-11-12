defmodule SimpleSubscriptionManagerWeb.AccountSettingsController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Accounts
  alias SimpleSubscriptionManagerWeb.AccountAuth

  plug :assign_email_and_password_and_name_changesets

  def edit(conn, _params) do

    today = Date.utc_today()
    IO.puts "現在のconn.assigns"
    IO.inspect(conn.assigns)

    render(conn, "edit.html", today: today)
  end

  # メールアドレスの変更
  def update(conn, %{"action" => "update_email"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    # メール配送処理
    case Accounts.apply_account_email(account, password, account_params) do
      {:ok, applied_account} ->
        Accounts.deliver_update_email_instructions(
          applied_account,
          account.email,
          &Routes.account_settings_url(conn, :confirm_email, &1)
        )

        conn
        |> put_flash(
          :info,
          "A link to confirm your email change has been sent to the new address."
        )
        |> redirect(to: Routes.account_settings_path(conn, :edit))

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", email_changeset: changeset, today: today)
    end
  end

  # パスワードの変更
  def update(conn, %{"action" => "update_password"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    # IO.puts "受け取ったパスワード: #{password}, 受け取ったアカウント情報\n#{account_params}"

    account = conn.assigns.current_account

    case Accounts.update_account_password(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "パスワードの変更に成功しました。")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", password_changeset: changeset, today: today)
    end
  end

  def confirm_email(conn, %{"token" => token}) do
    case Accounts.update_account_email(conn.assigns.current_account, token) do
      :ok ->
        conn
        |> put_flash(:info, "Email changed successfully.")
        |> redirect(to: Routes.account_settings_path(conn, :edit))

      :error ->
        conn
        |> put_flash(:error, "Email change link is invalid or it has expired.")
        |> redirect(to: Routes.account_settings_path(conn, :edit))
    end
  end

  # 名前の変更
  def update(conn, %{"action" => "update_name"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    IO.puts "受け取ったparams"
    IO.inspect params
    account = conn.assigns.current_account

    case Accounts.update_account_name(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "名前の変更に成功しました。")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", password_changeset: changeset, today: today)
    end
  end

  # ageの変更
  def update(conn, %{"action" => "update_age"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Accounts.update_account_age(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "年齢の変更に成功しました。")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", password_changeset: changeset, today: today)
    end
  end

  # 性別の変更
  def update(conn, %{"action" => "update_gender"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    account = conn.assigns.current_account

    case Accounts.update_account_gender(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "性別の変更に成功しました。")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", password_changeset: changeset, today: today)
    end
  end

  # ユーザ情報の利用許可を変更する
  def update(conn, %{"action" => "update_use_user_info"} = params) do
    %{"current_password" => password, "account" => account_params} = params
    IO.puts "受け取ったparams"
    IO.inspect params
    account = conn.assigns.current_account

    case Accounts.update_account_use_user_info(account, password, account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "ユーザ情報の利用の変更に成功しました。")
        |> put_session(:account_return_to, Routes.account_settings_path(conn, :edit))
        |> AccountAuth.log_in_account(account)

      {:error, changeset} ->
        today = Date.utc_today()
        render(conn, "edit.html", password_changeset: changeset, today: today)
    end
  end

  # 各項目のchangesetをassignsに追加する
  defp assign_email_and_password_and_name_changesets(conn, _opts) do
    account = conn.assigns.current_account

    conn
    |> assign(:email_changeset, Accounts.change_account_email(account))
    |> assign(:password_changeset, Accounts.change_account_password(account))
    |> assign(:name_changeset, Accounts.change_account_name(account))
    |> assign(:age_changeset, Accounts.change_account_age(account))
    |> assign(:gender_changeset, Accounts.change_account_gender(account))
    |> assign(:use_user_info_changeset, Accounts.change_account_use_user_info(account))
  end
end
