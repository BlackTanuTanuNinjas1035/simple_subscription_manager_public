defmodule SimpleSubscriptionManager.Subscribes do
  alias SimpleSubscriptionManager.Subscribes.Subscribe
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
    |> Repo.preload(:subscription_alias)
  end

  @doc """
  use_user_infoがtrueであるアカウントのサブスクライブ情報を取得
  """
  def get_subscribes_of_available_user() do

    # use_user_infoがtrueであるクエリ
    sub_query = from(a in Account, where: a.use_user_info == true)
    # を含むクエリ(join)
    query = from(s in Subscribe, preload: [account_alias: ^sub_query])
    # subscriptionとjoin
    full_query = Repo.all(query) |> Repo.preload(:subscription_alias)


    # サービスごとの件数
    subscription_counter = Enum.reduce(full_query, %{}, fn s, acc -> Map.update(acc, s.subscription_alias.name, 1, &(&1+1)) end)

  end

  @doc """
  全体の何割から回答を得られたか(小数点第1で四捨五入)を返却
  """
  def anser_counter() do
    all_user = Repo.one(from(a in Account, select: count(a)))
    true_user = Repo.one(from(a in Account, where: a.use_user_info == true, select: count(a)))
    Float.ceil(true_user / all_user, 1)
  end
end
