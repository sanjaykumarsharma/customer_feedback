defmodule CustomerFeedback.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  schema "accounts" do
    field(:name, :string)
    field(:address, :string)
    field(:city, :string)
    field(:state, :string)
    field(:pin, :string)
    field(:phone, :string)
    field(:status, :string)
    field(:email, :string)
    field(:user_name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:valid_upto, :date)
    field(:picture, :string)

    timestamps()

    # has_many(:users, CustomerFeedback.Account.User)
    # has_many(:questions, CustomerFeedback.Settings.Question)
    # has_many(:ratings, CustomerFeedback.Ratings.Rating)
    # has_many(:customers, CustomerFeedback.Customers.Rating)
  end

  def signup_changeset(access, attrs) do
    access
    |> cast(attrs, [
      :id,
      :name,
      :address,
      :city,
      :state,
      :pin,
      :phone,
      :status,
      :email,
      :user_name,
      :password,
      :password_hash,
      :valid_upto,
      :picture
    ])
    |> validate_required([
      :name,
      :email,
      :phone,
      :user_name,
      :password
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  def changeset(access, attrs) do
    access
    |> cast(attrs, [
      :id,
      :name,
      :address,
      :city,
      :state,
      :pin,
      :phone,
      :status,
      :email,
      :user_name,
      :password,
      :password_hash,
      :valid_upto,
      :picture
    ])
    |> validate_required([
      :name,
      :email,
      :phone,
      :city,
      :state,
      :pin,
      :user_name
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:password, min: 3)
  end

  def login_changeset(access, attrs) do
    access
    |> cast(attrs, [
      :user_name,
      :password
    ])
    |> validate_required([
      :user_name,
      :password
    ])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
