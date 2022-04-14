defmodule TecsolfacilWeb.Api.V1.UserView do
  use TecsolfacilWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end

  def render("401.json", _) do
    %{error: %{detail: "Unauthenticated"}}
  end

  def render("400.json", _) do
    %{error: %{detail: "User not found in body params"}}
  end
end
