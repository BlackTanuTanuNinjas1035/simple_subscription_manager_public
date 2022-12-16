defmodule SimpleSubscriptionManager.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :index, :integer
      add :image, :string
      add :name, :string
      add :text, :string
      add :direction, :string

      timestamps()
    end
  end
end
