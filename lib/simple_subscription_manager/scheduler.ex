defmodule SimpleSubscriptionManager.Scheduler do
  use Quantum, otp_app: :simple_subscription_manager

  alias SimpleSubscriptionManager.Historys
  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Util
  alias SimpleSubscriptionManager.Subscribes.SubscribeNotifier
  alias SimpleSubscriptionManager.Repo



  # Subscribesから支払期限が残り10日になったユーザにメールを送信する
  def check_date_of_payment() do
    subscribes_list = Subscribes.list_subscribe()

    for subscribe <- subscribes_list do
      unless subscribe.date_of_payment == nil do
        if Date.diff(Date.utc_today, subscribe.date_of_payment) == 10 do

          SubscribeNotifier.deliver_date_of_payment(
            subscribe.account_alias.email,
            subscribe.subscription_alias.name,
            subscribe.date_of_payment
          )

        end
      end
    end
  end

  # 支払当日になったとき、継続するなら支払日を翌月に更新。そうでないなら、サービスの登録を解除する
  def check_continue_subscription do

    subscribes_list = Subscribes.list_subscribe()

    for subscribe <- subscribes_list do
      unless subscribe.date_of_payment == nil do
        # 支払日当日
        if Date.diff(subscribe.date_of_payment, Date.utc_today) == 0 do
          # 継続するなら
          if subscribe.continue == true do

            date_of_payment = subscribe.date_of_payment

            if date_of_payment.month + 1 < 12 do
              Date.new!(date_of_payment.year, Util.add_month(date_of_payment.month,1),
                if Util.max_day(date_of_payment.year, Util.add_month(date_of_payment.month,1)) >= date_of_payment.day do
                  date_of_payment.day
                else
                  Util.max_day(date_of_payment.year, Util.add_month(date_of_payment.month,1))
                end
              )
            else
              Date.new!(date_of_payment.year + 1, 1,
                if Util.max_day(date_of_payment.year + 1, 1) >= date_of_payment.day do
                  date_of_payment.day
                else
                  Util.max_day(date_of_payment.year + 1, 1)
                end
              )
            end

            subscribe = Ecto.Changeset.change subscribe, date_of_payment: Date.new!(date_of_payment.year, date_of_payment.month+1, date_of_payment.day)

            case Repo.update subscribe do
              {:ok, subscribe} ->

                IO.puts "支払日の更新 成功: #{subscribe.account_alias.name} #{subscribe.account_alias.name}"

                case Historys.insert_history(
                  %{
                    account_id: subscribe.account_id,
                    subscription_id: subscribe.subscription_id,
                    date_of_contract: subscribe.date_of_contract,
                    continue: subscribe.continue,
                    date_of_payment: subscribe.date_of_payment,
                  }
                ) do
                  {:ok, msg} -> IO.puts msg
                  {:error, msg} -> IO.puts msg
                end

              {:error, _changeset} ->
                IO.puts "支払日の更新 失敗"
            end
          else
            case Subscribes.delete_subscribe(subscribe.account_id, subscribe.subscription_id) do
              {:ok, msg} -> {:ok, IO.puts msg}
              {:error, msg} -> {:ok, IO.puts msg}
            end
          end
        end
      end
    end
  end

  @doc """
  毎日DBのバックアップをとる
  """
  def postgres_backup() do
    if File.exists? "../db" do
      System.cmd("mkdir", ["../db"])
    end
    System.cmd("pg_dump", ["simple_subscription_manager_dev", ">", "../db/`date +%Y年%m月%d日`_db.backup"])
  end

  @doc """
  毎月DBのアーカイブを作成をする
  """
  def postgres_backup_tar() do
    if File.exists? "../db/db_archive" do
      System.cmd("mkdir", ["../db/db_archive"])
    end
    if File.exists? "../db/*_db.backup" do
      System.cmd("tar", ["czf", "../db/db_archive/`date +%Y年%m月`_db.tar.gz", "../db/*_db.backup", "--remove-files"])
    end
  end
end
