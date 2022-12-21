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
              Date.new!(date_of_payment.year, Util.add_month(date_of_payment.month,1), date_of_payment.day)
            else
              Date.new!(date_of_payment.year + 1, 1, date_of_payment.day)
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
end
