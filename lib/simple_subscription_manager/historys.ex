defmodule SimpleSubscriptionManager.Historys do
  alias SimpleSubscriptionManager.Historys.History
  alias SimpleSubscriptionManager.Repo
  alias SimpleSubscriptionManager.Converter
  alias SimpleSubscriptionManager.Util

  import Ecto.Query

  @doc """
  属性の入力が正しいかsubscribe検査->登録する
  """
  def register_history(attrs) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  指定したユーザの指定した月の履歴を表示する
  """
  def get_history(account_id, month) do
    today= Date.utc_today()
    tomonth = today.month

    History
    |> where(account_id: ^account_id)
    |> Repo.all
    |> Repo.preload([:account_alias, :subscription_alias, subscription_alias: [:genre_alias]])
    |> Enum.filter(fn record -> Date.diff(today, NaiveDateTime.to_date(record.inserted_at)) <= 365 end)
    |> Enum.filter(fn record -> Util.adjust_month(tomonth + record.date_of_contract.month) == month end)
  end

  @doc """
  指定した履歴を削除する
  """
  def delete_history(history_id) do
    record = Repo.get!(History, history_id)
    case Repo.delete(record) do
      {:ok, _struct} -> {:ok, "履歴の削除に成功しました"}
      {:error, _changeset} -> {:ok, "履歴の削除に失敗しました"}
    end
  end

  # def insert_history(history_id) do
  #   record = %History{
  #     account_id: subscribe.account_id,
  #     subscription_id: subscribe.subscription_id,
  #     date_of_contract: subscribe.date_of_contract,
  #     continue: subscribe.continue,
  #     date_of_payment: subscribe.date_of_payment,
  #   }
  #   case Repo.insert record do
  #     {:ok, _struct} -> IO.puts "履歴の追加に成功しました"
  #     {:error, _changeset} -> IO.puts "履歴の追加に失敗しました"
  #   end
  # end

  def insert_history(attr) do
    %History{}
    |> History.changeset(attr)
    |> Repo.insert()
    |> case do
      {:ok, _struct} -> {:ok, "履歴の追加に成功しました"}
      {:error, _changeset} -> {:error, "履歴の追加に失敗しました"}
    end
  end

  @doc """
  ひと月に重複した履歴の登録がある場合の履歴の契約日と支払日を更新する
  """
  def update_history(account_id, subscribe_params) do
    record = Repo.get_by(History, account_id: account_id, subscription_id: subscribe_params["subscription_id"])
    record = Ecto.Changeset.change(record, date_of_contract: subscribe_params["date_of_contract"], date_of_payment: subscribe_params["date_of_payment"])
    case Repo.update record do
      {:ok, _struct}       -> {:ok, "履歴の契約日と支払日の更新に成功しました"}
      {:error, _changeset} -> {:error, "履歴の契約日と支払日の更新に失敗しました"}
    end
  end

  @doc """
  支払日を計算する。契約日の日にちが現在の日にちにより、支払日の値を決定する。
  契約日が12/1、現在の12/10なら支払日は1/1に決定する。12/20に契約しているなら、1/20
  """
  def caluclate_date_of_payment(subscribe_params) do

    if subscribe_params["date_of_contract"].day > Date.utc_today().day do
      Converter.convert! %{"year" => Date.utc_today().year, "month" => Date.utc_today().month, "day" => subscribe_params["date_of_contract"].day}
    else
      # if Integer.to_string(Date.utc_today().month + 1) != 13 do
      if Date.utc_today().month + 1 != 13 do
        Converter.convert! %{"year" => Date.utc_today().year, "month" => Date.utc_today().month + 1, "day" => subscribe_params["date_of_contract"].day}
      else
        Converter.convert! %{"year" => Date.utc_today().year + 1, "month" => 1, "day" => subscribe_params["date_of_contract"].day}
      end
    end

  end
end
