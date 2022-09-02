defmodule SimpleSubscriptionManager.Subscribes.Subscribe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscribes" do
    # account_idがaccountsのidと一致している行のエイリアス(idに対応するnameなど)を参照できる(フィールドにaccount_idとaccount_aliasを追加)
    belongs_to :account_alias, SimpleSubscriptionManager.Accounts.Account, foreign_key: :account_id, type: :integer
    belongs_to :subscription_alias, SimpleSubscriptionManager.Subscriptions.Subscription , foreign_key: :subscription_id, type: :integer

    timestamps()
  end

  @doc false
  def changeset(subscribe, attrs) do
    subscribe
    |> cast(attrs, [])
    |> validate_required([])
  end
end
