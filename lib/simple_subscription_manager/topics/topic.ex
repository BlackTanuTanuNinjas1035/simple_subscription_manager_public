defmodule SimpleSubscriptionManager.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :genre, :string
    field :text, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :text, :genre])
    |> validate_required([:title, :text, :genre])
  end
end
