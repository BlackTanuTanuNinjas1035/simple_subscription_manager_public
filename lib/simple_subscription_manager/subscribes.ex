defmodule SimpleSubscriptionManager.Subscribes do
  alias SimpleSubscriptionManager.Subscribes.Subscribe
  alias SimpleSubscriptionManager.Subscriptions
  alias SimpleSubscriptionManager.Accounts.Account
  alias SimpleSubscriptionManager.Repo
  import Ecto.Query

  @doc """
  Subscribeスキーマからaccountsテーブルのエイリアスとsubscriptionsテーブルのエイリアスを、使用できる形ですべて表示
  """
  def list_subscribe() do
    Repo.all(Subscribe)
    |> Repo.preload([:account_alias, :subscription_alias])
  end

  @doc """
  subscriptionの変更を追跡するchangesetを返す
  """
  def change_subscribe_registration(%Subscribe{} = subscribe, attrs \\ %{}) do
    Subscribe.changeset(subscribe, attrs)
  end

  @doc """
  subscribeを追跡&検査->登録する
  """
  def register_subscribe(attrs) do
    %Subscribe{}
    |> Subscribe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  与えられたcurrent_account_idと一致しているSubscribeのクエリを返却する
  """
  def get_subscribes(current_account_id) do

    IO.puts "Current Account: #{current_account_id}"

    query = Subscribe |> where(account_id: ^current_account_id)

    IO.puts "query:"
    IO.inspect Repo.all(query)

    # subscriptionsテーブルと関連付け(join)してから返却
    Repo.all(query, preload: [:subscription_alias])
    |> Repo.preload([:subscription_alias, subscription_alias: [:genre_alias]])
  end

  @doc """
  use_user_infoがtrueであるアカウントのサブスクライブ情報を取得。性別を数字で指定。(男性: 1, 女性: 2, 性別を指定しない場合(デフォルト): 0)
  """
  def get_subscribes_of_available_user(gender \\ 0) do

    # 性別指定なし or 性別指定ありでユーザ情報が利用可能なユーザの登録したサービスを取得
    query = if gender == 0 do
      Subscribe |> join(:inner, [sb], a in Account, on: sb.account_id == a.id) |> preload([:account_alias, :subscription_alias, subscription_alias: :genre_alias]) |> Repo.all
    else
      Subscribe |> join(:inner, [sb], a in Account, on: sb.account_id == a.id and a.gender == ^gender) |> preload([:account_alias, :subscription_alias, subscription_alias: :genre_alias]) |> Repo.all
    end

    # サービスごとの件数をカウントする
    subscription_counter = Enum.reduce(query, %{}, fn s, acc -> Map.update(acc, s.subscription_alias.name, 1, &(&1+1)) end)

    # DBに登録しているサービスの名前とジャンルの名前の組み合わせを取得する
    genre_name_list = for x <- Subscriptions.list_subscriptions do
      {x.name, x.genre_alias.name}
    end

    name_point_genre = []

    # サービスの名前とポイントと、ジャンルの名前を合体させる
    genre_name_list |>
    Enum.map(fn g ->
      point = Map.get(subscription_counter, elem(g, 0))
      if point != nil do
        name_point_genre = name_point_genre ++ [elem(g, 0), elem(g, 1), point]
      end
    end)

  end

  @doc """
  登録情報の利用許可をしているアカウント数を取得
  """
  def answer_counter() do
    Repo.one(from(a in Account, where: a.use_user_info == true, select: count(a)))
  end

  @doc """
  利用許可されたユーザが、全体の何割か(小数点第1で四捨五入)を返却
  """
  def answer_ratio() do
    all_user = Repo.one(from(a in Account, select: count(a)))
    true_user = answer_counter()
    Float.ceil(true_user / all_user, 1)
  end

  @doc """
  subscribe_idと一致しているサブスクライブを削除する
  """
  def delete_subscribe(id) do
    Repo.get(Subscribe, id)
    |> Repo.delete
    |> case do
      {:ok, _struct} -> {:ok, "サブスクライブの削除に成功"}
      {:error, _changeset} -> {:error, "サブスクライブの削除に失敗"}
    end
  end

  def update_day_of_payment(id, date_of_payment) do
    subscribe = Repo.get Subscribe, id
    Ecto.Changeset.change(subscribe, date_of_payment: date_of_payment)
    |> Repo.update
    |> case do
      {:ok, _} -> IO.puts "サブスクライブの更新に成功しました"
      {:error, _} -> IO.puts "サブスクライブの更新に失敗しました"
    end
  end
end
