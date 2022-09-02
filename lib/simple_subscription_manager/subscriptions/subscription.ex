defmodule SimpleSubscriptionManager.Subscriptions.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :genre, :string
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:name, :genre, :price])
    |> validate_required([:name, :genre, :price])
  end
end
