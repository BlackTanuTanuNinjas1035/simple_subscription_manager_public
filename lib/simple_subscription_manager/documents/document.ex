defmodule SimpleSubscriptionManager.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :example, :string
    field :format, :string
    field :image, :string
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :text, :example, :image, :format])
    |> validate_required([:name, :text, :example, :image, :format])
  end
end
