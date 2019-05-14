defmodule CustomerFeedback.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string, null: false
      add :password_hash, :string
      add :name, :string
      add :mobile_no, :string
      add :email, :string
      add :picture, :string, null: true
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:users, [:account_id])
    create unique_index(:users, [:account_id,:user_name])
  end
end