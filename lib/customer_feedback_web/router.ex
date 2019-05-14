defmodule CustomerFeedbackWeb.Router do
  use CustomerFeedbackWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CustomerFeedbackWeb do
    pipe_through :browser

    get "/signup", LoginController, :signup
    post "/signup", LoginController, :create_account
  end

  # new code
  pipeline :auth do
    plug Auth.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug :put_user_token
  end

  defp put_user_token(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    conn = Plug.Conn.assign(conn, :current_user, user)
  end

  # Maybe logged in routes
  scope "/", CustomerFeedbackWeb do
    pipe_through [:browser, :auth]

    get "/", LoginController, :index

    post "/", LoginController, :authenticate_account

    # get "/login", SessionController, :new
    # post "/login", SessionController, :login
    # post "/logout", SessionController, :logout
  end

  # Definitely logged in scope
  scope "/", CustomerFeedbackWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/secret", LoginController, :secret
    get "/profile", ProfileController, :index
    get "/edit", ProfileController, :edit
    put "/edit", ProfileController, :update_profile

    resources "/questions", QuestionController
    resources "/ratings", RatingController
  end
end
