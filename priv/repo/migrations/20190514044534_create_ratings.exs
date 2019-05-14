defmodule CustomerFeedback.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :mobile, :string
      add :rating, :integer
      add :rating_date, :date
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid)

    end

    create index(:ratings, [:account_id])
    create index(:ratings, [:mobile])
    create index(:ratings, [:rating_date])
  end
end
