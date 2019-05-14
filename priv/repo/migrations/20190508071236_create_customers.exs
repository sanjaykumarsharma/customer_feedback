defmodule CustomerFeedback.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :mobile, :string
      add :name, :string
      add :dob, :date, null: true, default: nil
      add :doa, :date, null: true, default: nil
      add :email, :string, null: true, default: nil
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    
    create unique_index(:customers, [:account_id, :mobile])
    create index(:customers, [:dob])
    create index(:customers, [:doa])
  end
end