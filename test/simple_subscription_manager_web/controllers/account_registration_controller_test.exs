defmodule SimpleSubscriptionManagerWeb.AccountRegistrationControllerTest do
  use SimpleSubscriptionManagerWeb.ConnCase, async: true

  import SimpleSubscriptionManager.AccountsFixtures

  describe "GET /accounts/register" do
    test "renders registration page", %{conn: conn} do
      conn = get(conn, Routes.account_registration_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>アカウントの登録</h1>"

    end

    test "redirects if already logged in", %{conn: conn} do
      conn = conn |> log_in_account(account_fixture()) |> get(Routes.account_registration_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /accounts/register" do
    @tag :capture_log
    test "creates account and logs the account in", %{conn: conn} do
      email = unique_account_email()

      conn =
        post(conn, Routes.account_registration_path(conn, :create), %{
          "account" => valid_account_attributes(email: email)
        })

      assert get_session(conn, :account_token)
      assert redirected_to(conn) == "/"

      # ログイン後に画面上部が切り替わっていることを確認
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ email
      assert response =~ "アカウントの設定をする</a>"
      assert response =~ "ログアウトする</a>"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.account_registration_path(conn, :create), %{
          "account" => %{"email" => "with spaces", "password" => "too short", }
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Register</h1>"
      assert response =~ "must have the @ sign and no spaces"
      assert response =~ "should be at least 12 character"
    end
  end
end
