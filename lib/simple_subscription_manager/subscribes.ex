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

    # # idがcurrent_account_idと一致するクエリを返却。SELECT * FROM Account AS a WHEHR a.id == ^current_account_id;
    # preload_query = from(a in Account, where: a.id == ^current_account_id)

    # IO.puts "preload_query:"
    # IO.inspect Repo.all(preload_query)

    # # ココらへんが問題

    # # 上記preloa_queryを持つクエリを取得(つまりidがcurrent_account_idと一緒であるsubscribesテーブルのクエリの返却)
    # query = from(s in Subscribe, preload: [account_alias: ^preload_query])

    query = Subscribe |> where(account_id: ^current_account_id)

    IO.puts "query:"
    IO.inspect Repo.all(query)

    # subscriptionsテーブルと関連付け(join)してから返却
    Repo.all(query, preload: [:subscription_alias])
    |> Repo.preload(:subscription_alias)
  end

end
