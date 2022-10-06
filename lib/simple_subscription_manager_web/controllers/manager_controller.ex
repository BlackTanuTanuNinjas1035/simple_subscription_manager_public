defmodule SimpleSubscriptionManagerWeb.ManagerController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Subscribes.Subscribe

  alias SimpleSubscriptionManager.Subscriptions


  @doc """
  Subscribeから全件取得->変更の追跡をするchagesetを取得->renderに渡してindex.htmlを表示
  """
  def index(conn, _params) do
    changeset = Subscribe.changeset(%Subscribe{}, %{})

    # 現在のconnに入っているcurrent_account属性のidを取得する
    current_id = conn.assigns[:current_account].id
    # IO.puts "現在のアカウントIDは、「#{current_id}」です"
    IO.inspect(conn.assigns.current_account)

    # 現在のアカウントが登録しているサブスクリプションのリストを取得する
    subscribes_list = Subscribes.get_subscribes(current_id)
    total_price = subscribes_list |> Enum.reduce(0, fn (x, acc) -> x.subscription_alias.price + acc end)

    conn
    |> render("index.html", subscribes_list: subscribes_list, changeset: changeset, total_price: total_price)
  end

  @doc """
  変更の追跡を追跡するchangesetを取得して
  """
  def new(conn,_pramas) do

    current_id = conn.assigns[:current_account].id
    IO.puts "現在のアカウントIDは、「#{current_id}」です"

    # セレクトボックスを表示するために、サブスクリプションの一覧を取得する
    subscription_list = Subscriptions.list_subscriptions()

    # IO.inspect subscription_list

    # 検証を取得
    changeset = Subscribes.change_subscribe_registration(%Subscribe{}, %{})

    # IO.inspect changeset

    render(conn, changeset: changeset, subscription_list: subscription_list)
  end

  @doc """
  subscribeの登録を行う-> :ok or :error が帰ってくる -> index.htmlにリダイレクト
  """
  def create(conn, %{"subscribe" => subscribe_params}) do

    IO.puts "before"
    IO.inspect subscribe_params

    # 受け取った属性(%{subscription_id}に、現在のカレントアカウントのid(account_id)を追加する
    current_id = conn.assigns[:current_account].id
    IO.puts current_id

    # 属性のキーはアトムでなく、文字列であることに注意
    subscribe_params = Map.put(subscribe_params, "account_id", current_id)


    case Subscribes.register_subscribe(subscribe_params)do
      {:ok, _} ->
        conn
        |> put_flash(:info, "サブスクリプションの追加に成功しました。")
        |> redirect(to: Routes.manager_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        subscription_list = Subscriptions.list_subscriptions()
        conn
        |> put_flash(:info, "サブスクリプションの登録に失敗しました。サービスの重複を確認してください。")
        |> render("new.html", changeset: changeset, subscription_list: subscription_list)
    end
  end
end
