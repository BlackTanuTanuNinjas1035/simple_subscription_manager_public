defmodule SimpleSubscriptionManagerWeb.PageControllerTest do
  use SimpleSubscriptionManagerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "あなたのための超シンプルなサブスクリプション管理"
  end
end
