defmodule Auth.ErrorHandler do
  use CustomerFeedbackWeb, :controller
  alias CustomerFeedbackWeb.Router.Helpers, as: Routes

  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)
    IO.inspect(body)

    conn
    |> put_flash(:info, "Login Required")
    |> redirect(to: Routes.login_path(conn, :index))
  end
end
