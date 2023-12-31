defmodule SimpleSubscriptionManager.Repo.Migrations.CreateAccountsAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:accounts) do
      # テンプレートから追加。ニックネーム
      add :name, :string, null: false
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      # 追加。誕生日(必須ではない)
      add :age, :date
      # 追加。性別(必須ではない)
      add :gender, :integer
      # 追加。ユーザ情報の利用許可
      add :use_user_info, :boolean, null: false
      add :confirmed_at, :naive_datetime
      timestamps()
    end

    create unique_index(:accounts, [:email])

    create table(:accounts_tokens) do
      add :account_id, references(:accounts, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:accounts_tokens, [:account_id])
    create unique_index(:accounts_tokens, [:context, :token])
  end
end
