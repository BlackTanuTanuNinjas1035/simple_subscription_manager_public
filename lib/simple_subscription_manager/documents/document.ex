defmodule SimpleSubscriptionManager.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :format, :string
    field :image, :string
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :text, :image, :format])
    |> validate_required([:name, :text, :image, :format])
  end
end
