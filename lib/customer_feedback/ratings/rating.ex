defmodule CustomerFeedback.Ratings.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type Ecto.UUID
  schema "ratings" do
    field :mobile, :string
    field :rating, :integer
    field :rating_date, :date
    # field :account_id, :id

    belongs_to(:account, CustomerFeedback.Accounts.Account)
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:mobile, :rating, :rating_date])
    |> validate_required([:mobile, :rating, :rating_date])
  end
end
