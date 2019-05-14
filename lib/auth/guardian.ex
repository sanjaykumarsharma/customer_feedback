defmodule Auth.Guardian do
  use Guardian, otp_app: :customer_feedback

  alias CustomerFeedback.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account_by_id(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
