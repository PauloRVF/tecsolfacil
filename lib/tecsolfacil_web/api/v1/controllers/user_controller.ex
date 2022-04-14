defmodule TecsolfacilWeb.Api.V1.UserController do
  use TecsolfacilWeb, :controller
  alias Tecsolfacil.Accounts

  def generate_token(conn, %{"user" => user} = _params) do
    %{"username" => username, "password" => password} = user

    if user = Accounts.user_get_by_username_and_password(username, password) do
      {:ok, token, _} = Accounts.Guardian.encode_and_sign(user, %{typ: "access"}, ttl: {1, :hour})

      conn
      |> render("token.json", token: token)
    else
      conn
      |> put_status(401)
      |> render("401.json")
    end
  end

  def generate_token(conn, _params) do
    conn
    |> put_status(400)
    |> render("400.json")
  end
end
