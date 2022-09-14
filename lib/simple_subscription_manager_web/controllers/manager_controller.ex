defmodule SimpleSubscriptionManagerWeb.ManagerController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Subscribes.Subscribe

  @doc """
  Subscribeから全件取得->変更の追跡をするchagesetを取得->renderに渡してindex.htmlを表示
  """
  def index(conn, _params) do
    subscribes = Subscribes.list_subscribe()
    changeset = Subscribe.changeset(%Subscribe{}, %{})
    conn
    |> render("index.html", subscribes: subscribes, changeset: changeset)
  end

  @doc """
  変更の追跡を追跡するchangesetを取得して
  """
  def new(conn,_pramas) do
    changeset = Subscribes.change_subscribe_registration(%Subscribe{}, %{})
    render(conn, changeset: changeset)
  end

  @doc """
  subscribeの登録を行う->:ok or :error が帰ってくる -> index.htmlにリダイレクト
  """
  def create(conn, %{"subscribe" => subscribe_params}) do
      case Subscribes.register_subscribe(subscribe_params)do
        {:ok, _} ->
          conn
          |> put_flash(:info, "サブスクリプションの追加に成功しました。")
          |> redirect(to: Routes.manager_path(conn, :index))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "index.html", changeset: changeset)
      end
  end
end
