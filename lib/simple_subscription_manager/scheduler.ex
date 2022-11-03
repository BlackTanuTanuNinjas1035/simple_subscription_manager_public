defmodule SimpleSubscriptionManager.Scheduler do
  use Quantum, otp_app: :simple_subscription_manager

  alias SimpleSubscriptionManager.Subscribes
  alias SimpleSubscriptionManager.Subscribes.SubscribeNotifier


  # Subscribesから支払期限が残り10日になったユーザにメールを送信する
  def check_date_of_payment() do
    subscribes_list = Subscribes.list_subscribe()

    # subscribes_list
    # |> Enum.map(
    #   fn subscribe ->
    #     if Date.diff(subscribe.date_of_payment,Date.utc_today) == 0 do
    #       SubscribeNotifier.deliver_date_of_payment(
    #         subscribe.account_alias.email,
    #         subscribe.subscription_alias.name,
    #         subscribe.date_of_payment
    #         )
    #     end
    #   end
    # )

    for subscribe <- subscribes_list do
      if Date.diff(subscribe.date_of_payment,Date.utc_today) == 0 do
        SubscribeNotifier.deliver_date_of_payment(
          subscribe.account_alias.email,
          subscribe.subscription_alias.name,
          subscribe.date_of_payment
        )
      end
    end
  end
end
