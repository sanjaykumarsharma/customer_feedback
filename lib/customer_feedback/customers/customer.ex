defmodule CustomerFeedback.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type Ecto.UUID

  schema "customers" do
    field :doa, :date
    field :dob, :date
    field :email, :string
    field :mobile, :string
    field :name, :string
    # field :account_id, :id

    timestamps()

    belongs_to(:account, CustomerFeedback.Accounts.Account)
  end

  @required_fields ~w(mobile name)a
  @optional_fields ~w(dob doa email)a

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
  end
end
