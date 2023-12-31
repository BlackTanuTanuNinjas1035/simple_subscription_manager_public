defmodule SimpleSubscriptionManagerWeb.AccountSessionControllerTest do
  use SimpleSubscriptionManagerWeb.ConnCase, async: true

  import SimpleSubscriptionManager.AccountsFixtures

  setup do
    %{account: account_fixture()}
  end

  describe "GET /accounts/log_in" do
    test "renders log in page", %{conn: conn} do
      conn = get(conn, Routes.account_session_path(conn, :new))
      response = html_response(conn, 200)
      assert response =~ "<h1>Log in</h1>"
      assert response =~ "アカウントの登録</a>"
      assert response =~ "パスワードを忘れたら？</a>"
    end

    test "redirects if already logged in", %{conn: conn, account: account} do
      conn = conn |> log_in_account(account) |> get(Routes.account_session_path(conn, :new))
      assert redirected_to(conn) == "/"
    end
  end

  describe "POST /accounts/log_in" do
    test "logs the account in", %{conn: conn, account: account} do
      conn =
        post(conn, Routes.account_session_path(conn, :create), %{
          "account" => %{"email" => account.email, "password" => valid_account_password()}
        })

      assert get_session(conn, :account_token)
      assert redirected_to(conn) == "/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, "/")
      response = html_response(conn, 200)
      assert response =~ account.email
      assert response =~ "アカウントの登録をする</a>"
      assert response =~ "ログインする</a>"
    end

    test "logs the account in with remember me", %{conn: conn, account: account} do
      conn =
        post(conn, Routes.account_session_path(conn, :create), %{
          "account" => %{
            "email" => account.email,
            "password" => valid_account_password(),
            "remember_me" => "true"
          }
        })

      assert conn.resp_cookies["_simple_subscription_manager_web_account_remember_me"]
      assert redirected_to(conn) == "/"
    end

    test "logs the account in with return to", %{conn: conn, account: account} do
      conn =
        conn
        |> init_test_session(account_return_to: "/foo/bar")
        |> post(Routes.account_session_path(conn, :create), %{
          "account" => %{
            "email" => account.email,
            "password" => valid_account_password()
          }
        })

      assert redirected_to(conn) == "/foo/bar"
    end

    test "emits error message with invalid credentials", %{conn: conn, account: account} do
      conn =
        post(conn, Routes.account_session_path(conn, :create), %{
          "account" => %{"email" => account.email, "password" => "invalid_password"}
        })

      response = html_response(conn, 200)
      assert response =~ "<h1>Log in</h1>"
      assert response =~ "メールアドレスかパスワードの検証に失敗しました"
    end
  end

  describe "DELETE /accounts/log_out" do
    test "logs the account out", %{conn: conn, account: account} do
      conn = conn |> log_in_account(account) |> delete(Routes.account_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :account_token)
      assert get_flash(conn, :info) =~ "ログアウトしました。"
    end

    test "succeeds even if the account is not logged in", %{conn: conn} do
      conn = delete(conn, Routes.account_session_path(conn, :delete))
      assert redirected_to(conn) == "/"
      refute get_session(conn, :account_token)
      assert get_flash(conn, :info) =~ "ログアウトしました。"
    end
  end
end
