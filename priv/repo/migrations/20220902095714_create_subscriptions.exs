defmodule SimpleSubscriptionManager.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :name, :string
      add :genre, :string
      add :price, :integer

      timestamps()
    end
  end
end
