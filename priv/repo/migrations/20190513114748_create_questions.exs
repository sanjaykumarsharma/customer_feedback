defmodule CustomerFeedback.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create unique_index(:questions, [:account_id,:question])
  end
end
