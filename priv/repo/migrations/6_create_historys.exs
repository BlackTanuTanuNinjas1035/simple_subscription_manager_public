defmodule SimpleSubscriptionManager.Repo.Migrations.CreateHistorys do
  use Ecto.Migration

  @moduledoc """
  登録されたサービスの履歴を保存する
  """

  def change do
    create table(:historys) do
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :subscription_id, references(:subscriptions, on_delete: :delete_all), null: false
      add :date_of_contract, :date, null: false
      add :continue, :boolean
      add :date_of_payment, :date
      timestamps()
    end

    # 3ヶ月までの履歴を取るので、ユニーク制約とはならない
    # create unique_index(:historys, [:account_id, :subscription_id])
  end
end
