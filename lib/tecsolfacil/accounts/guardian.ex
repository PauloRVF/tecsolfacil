defmodule Tecsolfacil.Accounts.Guardian do
  use Guardian, otp_app: :tecsolfacil

  @moduledoc """
    Guardian provider for user resource authentication
  """
  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :reason_for_error}

  def resource_from_claims(%{"sub" => id}) do
    resource = Tecsolfacil.Accounts.user_get_by_id(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims), do: {:error, :reason_for_error}
end
