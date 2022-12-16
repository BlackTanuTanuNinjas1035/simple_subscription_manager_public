defmodule SimpleSubscriptionManager.Subscribes do
  alias SimpleSubscriptionManager.Subscribes.Subscribe
  alias SimpleSubscriptionManager.Subscriptions
  alias SimpleSubscriptionManager.Accounts.Account
  alias SimpleSubscriptionManager.Repo
  alias SimpleSubscriptionManager.Subscribes.History
  alias SimpleSubscriptionManager.Converter
  import Ecto.Query

  @doc """
  Subscribeスキーマからaccountsテーブルのエイリアスとsubscriptionsテーブルのエイリアスを、使用できる形ですべて表示
  """
  def list_subscribe() do
    Repo.all(Subscribe)
    |> Repo.preload([:account_alias, :subscription_alias, subscription_alias: [:genre_alias]])
  end

  @doc """
  入力された属性が正しいか検証するためのchangesetを返す
  """
  def change_subscribe_registration(%Subscribe{} = subscribe, attrs \\ %{}) do
    Subscribe.changeset(subscribe, attrs)
  end

  @doc """
  入力された属性が正しいかsubscribe検証して登録する
  """
  def register_subscribe(attrs) do
    %Subscribe{}
    |> Subscribe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  与えられたidと一致しているユーザの登録したサービスを返却する
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
  登録情報を利用可能にしているアカウントが、登録しているサブスクライブ情報を取得。
  性別を数字で指定。(男性: 1, 女性: 2, 性別を指定しない場合(デフォルト): 0)。
  ユーザの年代を指定(例: 10)。nilで指定しない。

  ## Examples
      iex> Subscribes.get_subscribes_ranking 1
      [
        ["Netflix(ベーシック)", "動画配信サービス", 2, 0.334],
        ["U-NEXT", "動画配信サービス", 1, 0.167],
        ["Hulu", "動画配信サービス", 1, 0.167],
        ["Amazon Prime Video", "動画配信サービス", 1, 0.167],
        ["Youtubeプレミア", "動画配信サービス", 1, 0.167]
      ]
  """
  def get_subscribes_ranking(gender \\ 0, age \\ nil) do

    # サービス登録件数
    subscribe_count = Subscribe |> select([s], count(s.id)) |> Repo.one

    query = if age == nil do
      get_subscribes_by_available_user(gender)
    else
      divide_by_age_group(get_subscribes_by_available_user(gender), age) |> Enum.reject(&is_nil/1)
    end

    IO.inspect query

    # サービス種類ごとの登録件数
    subscription_counter = Enum.reduce(query, %{}, fn s, acc -> Map.update(acc, s.subscription_alias.name, 1, &(&1+1)) end)

    # DBに登録しているサービスの名前とジャンルの名前の組み合わせを取得する
    genre_name_list = for x <- Subscriptions.list_subscriptions do
      {x.name, x.genre_alias.name}
    end

    name_point_genre = []

    # サービスの名前とポイントと、ジャンルの名前を合体させる->件数でソート
    genre_name_list |>
    Enum.map(fn g ->
      point = Map.get(subscription_counter, elem(g, 0))
      if point != nil do
        name_point_genre = name_point_genre ++ [elem(g, 0), elem(g, 1), point, Float.ceil(point/subscribe_count, 3)]
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.sort_by(fn x -> Enum.at(x, 2) end, :desc)

  end
  # 性別指定なし or 性別指定ありでユーザ情報が利用可能なユーザの登録したサービスを取得
  defp get_subscribes_by_available_user(gender \\ 0) do
    if gender == 0 do
      Subscribe |> join(:inner, [sb], a in Account, on: sb.account_id == a.id) |> preload([:account_alias, :subscription_alias, subscription_alias: :genre_alias]) |> Repo.all
    else
      Subscribe |> join(:inner, [sb], a in Account, on: sb.account_id == a.id and a.gender == ^gender) |> preload([:account_alias, :subscription_alias, subscription_alias: :genre_alias]) |> Repo.all
    end
  end
  # 登録サービス情報からageで指定した年代のものを取得。
  defp divide_by_age_group(subscribes, age) do
    today = Date.utc_today()
    age_group = []
    for s <- subscribes do
      if today.year - s.account_alias.age.year >= age and today.year - s.account_alias.age.year < age+10 do
        age_group = age_group ++ s
      end
    end
  end

  @doc """
  登録されたサービスの種類のランキングを出力

    ## Examles
      iex> Subscribes.get_genres_ranking
      [{"動画配信サービス", 2, 0.5},{"漫画・小説配信サービス", 2, 0.5}]
  """
  def get_genres_ranking(gender \\ 0, age \\ nil) do
    service_ranking = get_subscribes_ranking(gender, age)

    # %{"動画配信サービス" => 5, ...}
    genre_ranking = Enum.reduce(service_ranking, %{}, fn s, acc -> Map.update(acc, Enum.at(s, 1), 1, &(&1+1)) end)
    IO.inspect genre_ranking

    genre_count = Enum.reduce(Map.to_list(genre_ranking), 0, fn genre, acc -> elem(genre, 1) + acc end)

    Map.to_list(genre_ranking) |>
    Enum.map(fn genre -> {elem(genre,0), elem(genre, 1), Float.ceil(elem(genre, 1)/genre_count, 3)} end)
    |> Enum.sort_by(fn x -> elem(x, 1) end, :desc)

  end

  @doc """
  登録情報の利用許可をしているアカウント数を取得
  """
  def available_counter() do
    Repo.one(from(a in Account, where: a.use_user_info == true, select: count(a)))
  end

  @doc """
  利用許可されたユーザが、全体の何割か(小数点第1で四捨五入)を返却
  """
  def available_percent() do
    all_user = Repo.one(from(a in Account, select: count(a)))
    true_user = available_counter()
    Float.ceil(true_user / all_user, 3)
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

  @doc """
  登録したサービス内容を更新する。(継続、契約日)
  """
  def update_subsribe(id, subscribe_params) do

    subscribe = Repo.get Subscribe, id

    subscribe = Ecto.Changeset.change(subscribe, date_of_contract: Converter.convert!(subscribe_params["date_of_contract"]), continue: subscribe_params["continue"])
    Repo.update(subscribe)
    |> case do
      {:ok, _} -> {:ok, "契約日の更新に成功しました"}
      {:error, _} -> {:error, "契約日の更新に失敗しました"}
    end

  end

  @doc """
  スケジューラ用。
  """
  def delete_subscribe(account_id, subscription_id) do
    record = Repo.get_by(Subscribe, account_id: account_id, subscription_id: subscription_id)
    case Repo.delete record do
      {:ok, _struct} -> {:ok, "レコードの削除に成功しました"}
      {:error, _changeset} -> {:error, "レコードの削除に失敗しました"}
    end
  end

end
