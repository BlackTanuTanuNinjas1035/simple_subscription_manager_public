defmodule SimpleSubscriptionManager.Talks.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :index, :integer
    field :image, :string
    field :name, :string
    field :text, :string
    field :direction, :string

    timestamps()
  end

  @doc false
  def changeset(talk, attrs) do
    talk
    |> cast(attrs, [:index, :image, :name, :text, :direction])
  end
end
