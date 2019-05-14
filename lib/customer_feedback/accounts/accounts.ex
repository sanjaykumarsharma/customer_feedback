defmodule CustomerFeedback.Accounts do
  import Ecto.Query, warn: false
  alias CustomerFeedback.Repo

  alias CustomerFeedback.Accounts.Account

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.signup_changeset(attrs)
    |> Ecto.Changeset.put_change(:id, Ecto.UUID.generate())
    |> Ecto.Changeset.put_change(:status, "PV")
    |> IO.inspect()
    |> Repo.insert()
  end

  def get_account(user_name) do
    Repo.one(
      from(a in Account,
        where: a.user_name == ^user_name
      )
    )
  end

  def get_account_by_id(id) do
    Repo.one(
      from(a in Account,
        where: a.id == ^id
      )
    )
  end

  def update_account(%Account{} = a, attrs) do
    a
    |> Account.changeset(attrs)
    |> IO.inspect()
    |> Repo.update()
  end

  # defp get_password_hash(user_name) do
  #   Repo.one(
  #     from(a in Account,
  #       where: a.user_name == ^user_name,
  #       select: a.password_hash
  #     )
  #   )
  # end

  def change_account(%Account{} = account) do
    Account.signup_changeset(account, %{})
  end

  def authenticate_account(user_name, password) do
    record = get_account(user_name)
    IO.inspect(record)

    if record != nil do
      case Bcrypt.verify_pass(password, record.password_hash) do
        false -> false
        true -> {:ok, record}
      end
    else
      false
    end
  end

  def update_account_stuatus(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> IO.inspect()
    |> Repo.update()
  end

  def list_all_accounts do
    Repo.all(Account)
  end

  def delete_all_accounts do
    Repo.delete_all(Account)
  end
end
