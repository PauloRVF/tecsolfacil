defmodule TecsolfacilWeb.Api.V1.UserControllerTest do
  use TecsolfacilWeb.ConnCase, async: true
  alias Tecsolfacil.Accounts

  describe "generate_token/2" do
    test "when passing a valid user and password", %{conn: conn} do
      user_info = %{username: "admin", password: "5ECR7P455w0RD"}
      Accounts.user_create(user_info)

      conn = post(conn, Routes.user_path(conn, :generate_token, %{user: user_info}))

      response_body = json_response(conn, 200)
      assert %{"token" => _} = response_body
    end

    test "when is invalid user", %{conn: conn} do
      invalid_user_info = %{username: "invalid_user", password: "not_a_valid_password"}

      conn = post(conn, Routes.user_path(conn, :generate_token, %{user: invalid_user_info}))

      assert response_body = json_response(conn, 401)
      assert %{"error" => %{"detail" => "Unauthenticated"}} = response_body
    end

    test "when not user is passe", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :generate_token, %{}))

      assert response_body = json_response(conn, 400)
      assert %{"error" => %{"detail" => "User not found in body params"}} = response_body
    end
  end
end
