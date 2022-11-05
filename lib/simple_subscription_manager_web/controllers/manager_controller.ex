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
    date_of_payment_changeset = Subscribe.changeset(%Subscribe{}, %{})

    # 現在のconnに入っているcurrent_account属性のidを取得する
    current_id = conn.assigns[:current_account].id
    # IO.puts "現在のアカウントIDは、「#{current_id}」です"
    IO.inspect(conn.assigns.current_account)

    # 現在のアカウントが登録しているサブスクリプションのリストを取得する
    subscribes_list = Subscribes.get_subscribes(current_id)
    total_price = subscribes_list |> Enum.reduce(0, fn (x, acc) -> x.subscription_alias.price + acc end)

    to_year = Date.utc_today().year

    conn
    |> render(
        "index.html",
        subscribes_list: subscribes_list,
        changeset: changeset,
        total_price: total_price,
        date_of_payment_changeset: date_of_payment_changeset,
        to_year: to_year
      )
  end

  @doc """
  変更の追跡を追跡するchangesetを取得して
  """
  def new(conn,_pramas) do

    current_id = conn.assigns[:current_account].id
    IO.puts "現在のアカウントIDは、「#{current_id}」です"

    # 各ジャンルのサービスのクエリのリストを受け取る
    subscription_list = Subscriptions.list_subscriptions()
    subscription_list_by_video = Subscriptions.list_subscriptions_by_genre 1
    subscription_list_by_music = Subscriptions.list_subscriptions_by_genre 2
    subscription_list_by_car = Subscriptions.list_subscriptions_by_genre 3
    subscription_list_by_food = Subscriptions.list_subscriptions_by_genre 4
    subscription_list_by_software = Subscriptions.list_subscriptions_by_genre 5
    subscription_list_by_furniture = Subscriptions.list_subscriptions_by_genre 6
    subscription_list_by_lesson = Subscriptions.list_subscriptions_by_genre 7
    subscription_list_by_book = Subscriptions.list_subscriptions_by_genre 8


    # IO.inspect subscription_list

    # 検証を取得
    changeset = Subscribes.change_subscribe_registration(%Subscribe{}, %{})

    # IO.inspect changeset

    # 三年後までの支払日を登録できる
    to_year = Date.utc_today().year

    render(conn, changeset: changeset, to_year: to_year,
      subscription_list: subscription_list,
      subscription_list_by_video: subscription_list_by_video,
      subscription_list_by_music: subscription_list_by_music,
      subscription_list_by_car: subscription_list_by_car,
      subscription_list_by_food: subscription_list_by_food,
      subscription_list_by_software: subscription_list_by_software,
      subscription_list_by_furniture: subscription_list_by_furniture,
      subscription_list_by_lesson: subscription_list_by_lesson,
      subscription_list_by_book: subscription_list_by_book
    )
  end

  @doc """
  subscribeの登録を行う-> :ok or :error が帰ってくる -> index.htmlにリダイレクト
  """
  def create(conn, %{"subscribe" => subscribe_params}) do

    IO.puts "before"
    IO.inspect subscribe_params

    # 受け取った属性(%{subscription_id}に、現在のカレントアカウントのid(account_id)を追加する
    # subscribe_paramsにacccount_idフィールドに対応する現在のアカウントのidを挿入することで、subscribesテーブルに追加するための検証をクリアさせる
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

  # 登録したサービスを削除する
  def delete(conn, %{"subscribe_id" => subscribe_id}) do

    IO.puts"subscribe_id"
    IO.inspect subscribe_id

    case Subscribes.delete_subscribe(subscribe_id) do
      {:ok, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.manager_path(conn, :index))
      {:error, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.manager_path(conn, :index))
    end

  end

  # 登録したサービスの支払日を更新する
  def update(conn, %{"subscribe_id" => subscribe_id, "subscribe" => subscribe_params}) do

    IO.inspect(conn)
    IO.inspect "subscrbe_params: #{inspect subscribe_params["date_of_payment"]}"
    case Subscribes.update_date_of_payment(subscribe_id, subscribe_params["date_of_payment"]) do
      {:ok, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.manager_path(conn, :index))
      {:error, msg} ->
        conn
        |> put_flash(:info, msg)
        |> redirect(to: Routes.manager_path(conn, :index))
    end
  end
end
