defmodule SimpleSubscriptionManager.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :index, :integer
      add :image, :string
      add :name, :string
      add :text, :string
      add :is_left, :boolean, null: false

      timestamps()
    end
  end
end
