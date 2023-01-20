defmodule SimpleSubscriptionManagerWeb.AccountRegistrationController do
  use SimpleSubscriptionManagerWeb, :controller

  alias SimpleSubscriptionManager.Accounts
  alias SimpleSubscriptionManager.Util
  alias SimpleSubscriptionManager.Accounts.Account
  alias SimpleSubscriptionManagerWeb.AccountAuth

  def new(conn, _params) do

    # 今日の日付から西暦を取得したい
    today = Date.utc_today()

    changeset = Accounts.change_account_registration(%Account{})
    render(conn, "new.html", changeset: changeset, today: today)
  end

  def create(conn, %{"account" => account_params}) do

    IO.puts "account_params[\"age\"][\"year\"]: #{is_binary account_params["age"]["year"]}"

    account_params = update_in(account_params, ["age", "day"], fn day ->
      if String.to_integer(Util.max_day_by_string(account_params["age"]["year"], account_params["age"]["month"])) < String.to_integer(day) do
        Util.max_day_by_string(account_params["age"]["year"], account_params["age"]["month"])
      else
        account_params["age"]["day"]
      end
    end)


    IO.puts "aaccounts_params"
    IO.inspect account_params

    case Accounts.register_account(account_params) do
      {:ok, account} ->
        {:ok, _} =
          Accounts.deliver_account_confirmation_instructions(
            account,
            &Routes.account_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "アカウントの作成に成功しました。")
        |> AccountAuth.log_in_account(account)

      {:error, %Ecto.Changeset{} = changeset} ->
        today = Date.utc_today()
        conn
        |> put_flash(:info, "アカウントの作成に失敗しました。")
        |> render("new.html", changeset: changeset, today: today)
    end
  end
end
