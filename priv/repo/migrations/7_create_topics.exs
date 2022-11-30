defmodule SimpleSubscriptionManager.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :text, :string
      add :genre, :string

      timestamps()
    end
  end
end
