defmodule SimpleSubscriptionManager.Subscriptions.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :name, :string
    field :price, :integer
    field :description, :string
    belongs_to :genre_alias, SimpleSubscriptionManager.Subscriptions.Genre, foreign_key: :genre_id, type: :integer

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:name, :genre, :price])
    |> validate_required([:name, :genre, :price])
  end
end
