defmodule CustomerFeedback.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :address, :string, null: true, default: nil
      add :city, :string, null: true, default: nil
      add :state, :string, null: true, default: nil
      add :pin, :string, null: true, default: nil
      add :phone, :string, null: false
      add :status, :string
      add :email, :string, null: false
      add :user_name, :string, null: false
      add :password_hash, :string
      add :valid_upto, :date, null: true
      add :picture, :string, null: true

    timestamps()  
    end
    create unique_index(:accounts, [:user_name])
  end
end
