defmodule SimpleSubscriptionManager.Talks.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :index, :integer
    field :image, :string
    field :name, :string
    field :text, :string
    field :is_left, :boolean

    timestamps()
  end

  @doc false
  def changeset(talk, attrs) do
    talk
    |> cast(attrs, [:index, :image, :name, :text, :is_left])
    |> validate_required([:is_left])
  end
end
