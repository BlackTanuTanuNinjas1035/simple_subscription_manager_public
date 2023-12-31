defmodule SimpleSubscriptionManager.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string
      add :text, :string
      add :format, :string

      timestamps()
    end
  end
end
