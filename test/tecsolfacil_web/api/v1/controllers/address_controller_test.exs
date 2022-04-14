defmodule TecsolfacilWeb.Api.V1.AddressControllerTest do
  use TecsolfacilWeb.ConnCase, async: true
  use Oban.Testing, repo: Tecsolfacil.Repo
  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Addresses.ReportCsvByEmail
  alias Tecsolfacil.CepWs.Adapters.Mock, as: CepWsMock

  @valid_address %{cep: "00000000", logradouro: "rua teste, 1"}

  defp get_token do
    {:ok, user} = Accounts.user_create(%{username: "username", password: "password"})
    {:ok, token, _} = Accounts.Guardian.encode_and_sign(user, %{typ: "access"})
    token
  end

  describe "show/2" do
    test "when cep exists in database", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")
      Addresses.create(@valid_address)

      conn = get(conn, Routes.address_path(conn, :show, "00000000"))

      assert response_body = json_response(conn, 200)
      assert response_body["cep"] == "00000000"
      assert response_body["logradouro"] == "rua teste, 1"
    end

    test "when cep not exists in database but exists on WS", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")

      expected_body = %{
        "bairro" => "bairro",
        "cep" => "00000-000",
        "complemento" => "",
        "ddd" => "00",
        "gia" => "0000",
        "ibge" => "0000000",
        "localidade" => "cidade",
        "logradouro" => "Rua teste",
        "siafi" => "0000",
        "uf" => "UF"
      }

      Hammox.expect(CepWsMock, :request, fn _method, _endpoint ->
        {:ok, %{status: 200, body: expected_body}}
      end)

      conn = get(conn, Routes.address_path(conn, :show, "00000000"))

      assert response_body = json_response(conn, 200)
      assert response_body["cep"] == "00000000"
      assert response_body["logradouro"] == "Rua teste"
    end

    test "when cep don't exist in neither search sources", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")

      Hammox.expect(CepWsMock, :request, fn _method, _endpoint ->
        {:error, :not_found}
      end)

      conn = get(conn, Routes.address_path(conn, :show, "00000000"))

      assert response_body = json_response(conn, 404)
      assert response_body == %{"error" => %{"detail" => "cep 00000000 not found"}}
    end

    test "when is a badly formatted cep", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")

      Hammox.expect(CepWsMock, :request, fn _method, _endpoint ->
        {:error, :bad_request}
      end)

      conn = get(conn, Routes.address_path(conn, :show, "AAAAAAA"))

      assert response_body = json_response(conn, 400)
      assert response_body == %{"error" => %{"detail" => "bad request"}}
    end
  end

  describe "report/2" do
    test "when body contains an email", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")
      valid_body = %{"email" => "email@email.com.br"}
      conn = post(conn, Routes.address_path(conn, :report, valid_body))

      assert response_body = json_response(conn, 202)
      assert_enqueued(worker: ReportCsvByEmail, args: valid_body)
      assert response_body == %{"status" => "accepted, processing request"}
    end

    test "when body not contains an email", %{conn: conn} do
      conn = conn |> put_req_header("authorization", "Bearer #{get_token()}")
      valid_body = %{}
      conn = post(conn, Routes.address_path(conn, :report, valid_body))

      assert response_body = json_response(conn, 400)
      assert response_body == %{"error" => %{"detail" => "bad request"}}
    end
  end
end
