defmodule SimpleSubscriptionManager.Subscribes.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "historys" do
    belongs_to :account_alias, SimpleSubscriptionManager.Accounts.Account, foreign_key: :account_id, type: :integer
    belongs_to :subscription_alias, SimpleSubscriptionManager.Subscriptions.Subscription , foreign_key: :subscription_id, type: :integer
    field :date_of_contract, :date
    field :continue, :boolean
    field :date_of_payment, :date
    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:account_id, :subscription_id, :date_of_contract, :continue, :date_of_payment])
    |> validate_required([:account_id, :subscription_id, :date_of_contract, :continue])
    |> unsafe_validate_unique([:account_id, :subscription_id], SimpleSubscriptionManager.Repo)
  end
end
