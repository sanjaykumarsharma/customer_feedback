defmodule CustomerFeedbackWeb.ProfileController do
  use CustomerFeedbackWeb, :controller

  alias CustomerFeedback.Accounts.Account
  alias CustomerFeedback.Accounts

  alias Auth.Guardian

  def index(conn, _params) do
    profile = Accounts.get_account_by_id(conn.assigns.current_user.id)
    IO.inspect(profile)
    render(conn, "index.html", profile: profile)
  end

  def edit(conn, _params) do
    profile = Accounts.get_account_by_id(conn.assigns.current_user.id)
    changeset = Accounts.change_account(profile)
    render(conn, "name.html", profile: profile, changeset: changeset)
  end

  def update_profile(conn, %{"account" => profile_params}) do
    account = Accounts.get_account_by_id(conn.assigns.current_user.id)

    IO.inspect(account)

    case Accounts.update_account(account, profile_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: Routes.profile_path(conn, :index, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "name.html", account: account, changeset: changeset)
    end
  end
end
