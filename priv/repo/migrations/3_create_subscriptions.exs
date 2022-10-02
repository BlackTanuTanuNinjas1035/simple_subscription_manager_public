defmodule SimpleSubscriptionManager.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :name, :string, null: false
      add :genre_id, references(:genres, on_delete: :delete_all), null: false
      add :price, :integer, null: false
      add :description, :string, null: false

      timestamps()
    end
  end
end
