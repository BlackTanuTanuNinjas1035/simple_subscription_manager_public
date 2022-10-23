defmodule SimpleSubscriptionManager.Subscribes.Subscribe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscribes" do
    # account_idがaccountsのidと一致している行のエイリアス(idに対応するnameなど)を参照できる(フィールドにaccount_idとaccount_aliasを追加)
    belongs_to :account_alias, SimpleSubscriptionManager.Accounts.Account, foreign_key: :account_id, type: :integer
    belongs_to :subscription_alias, SimpleSubscriptionManager.Subscriptions.Subscription , foreign_key: :subscription_id, type: :integer
    # サブスクリプションの支払日
    field :date_of_payment, :date

    timestamps()
  end

  @doc false
  def changeset(subscribe, attrs) do
    subscribe
    |> cast(attrs, [:account_id, :subscription_id, :date_of_payment])
    |> validate_required([:account_id, :subscription_id])
    |> unsafe_validate_unique([:account_id, :subscription_id], SimpleSubscriptionManager.Repo)
    |> unique_constraint([:account_id, :subscription_id])
  end
end
