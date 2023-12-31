defmodule SimpleSubscriptionManager.Repo.Migrations.CreateSubscribes do
  use Ecto.Migration

  def change do
    create table(:subscribes) do
      # foreign key (account_id) references accounts (id)
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :subscription_id, references(:subscriptions, on_delete: :delete_all), null: false
      # 契約日
      add :date_of_contract, :date, null: false
      # 継続
      add :continue, :boolean, null: false, default: false
      # 支払日
      add :date_of_payment, :date
      timestamps()
    end

    # これらはユニーク制約となる
    create unique_index(:subscribes, [:account_id, :subscription_id])

  end
end
