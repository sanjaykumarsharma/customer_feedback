defmodule CustomerFeedbackWeb.LoginController do
  use CustomerFeedbackWeb, :controller

  alias CustomerFeedback.Accounts.Account
  alias CustomerFeedback.Accounts

  alias Auth.Guardian

  def index(conn, _params) do
    maybe_user = Guardian.Plug.current_resource(conn)

    if maybe_user do
      redirect(conn, to: "/secret")
    else
      render(conn, "index.html")
      # redirect(conn, to: "/login")
    end
  end

  def secret(conn, _params) do
    render(conn, "secret.html")
  end

  def authenticate_account(conn, %{"username" => username, "password" => password}) do
    case Accounts.authenticate_account(username, password) do
      {:ok, record} ->
        conn
        |> Guardian.Plug.sign_in(record)
        |> IO.inspect()
        |> redirect(to: "/secret")

      false ->
        IO.inspect("error occured")
        render(conn, "index.html", error: "invalid username or password")

        # |> redirect(to: batch_path(conn, :index))

        # {:error, %Ecto.Changeset{} = changeset} ->
        # render(conn, "index.html", changeset: changeset)
    end
  end

  def signup(conn, _params) do
    changeset = Accounts.change_account(%Account{})
    render(conn, "signup.html", changeset: changeset)
  end

  def create_account(conn, %{"account" => account_params}) do
    case Accounts.create_account(account_params) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> Guardian.Plug.sign_in(account)
        |> IO.inspect()
        |> redirect(to: "/secret")

      # |> redirect(to: Routes.account_path(conn, :show, account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "signup.html", changeset: changeset)
    end
  end
end
