defmodule SimpleSubscriptionManager.Repo.Migrations.CreateSubscribes do
  use Ecto.Migration

  def change do
    create table(:subscribes) do
      # foreign key (account_id) references accounts (id)
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :subscription_id, references(:subscriptions, on_delete: :delete_all), null: false

      timestamps()
    end

    # これらはユニーク制約となる
    create unique_index(:subscribes, [:account_id, :subscription_id])

  end
end
