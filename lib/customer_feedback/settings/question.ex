defmodule CustomerFeedback.Settings.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type Ecto.UUID
  schema "questions" do
    field :question, :string
    # field :account_id, :id

    timestamps()
    belongs_to(:account, CustomerFeedback.Accounts.Account)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question])
    |> validate_required([:question])
  end
end
