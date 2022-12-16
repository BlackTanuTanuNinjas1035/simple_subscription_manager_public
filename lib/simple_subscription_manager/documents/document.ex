defmodule SimpleSubscriptionManager.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :format, :string
    field :name, :string
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :text, :format])
    |> validate_required([:name, :text, :format])
  end
end
