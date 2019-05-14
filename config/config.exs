# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :customer_feedback,
  ecto_repos: [CustomerFeedback.Repo]

# Configures the endpoint
config :customer_feedback, CustomerFeedbackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XkkRcr8MyISbN287ypA9vh132iIXpwOn1KA6Mfk8Q4jW9ilVFpsMuv0lR2fRTMHY",
  render_errors: [view: CustomerFeedbackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CustomerFeedback.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :customer_feedback, Auth.Guardian,
  issuer: "customer_feedback",
  secret_key: "GRiN5njafYvD3DD6TyfHzU+NQdr8qnF47Hkw55bUuTDRChU2rUBA07KZ4tBTlcMk"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
