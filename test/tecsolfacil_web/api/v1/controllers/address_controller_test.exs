
defmodule TecsolfacilWeb.Api.V1.AddressControllerTest do
  use TecsolfacilWeb.ConnCase, async: true
  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Addresses.Address

  @valid_address %{cep: "00000000", logradouro: "rua teste, 1"}

  describe "show/2" do
    test "when is a valid cep", %{conn: conn} do
      Addresses.create(@valid_address)

      conn = get(conn, Routes.address_path(conn, :show, "00000000"))

      assert response_body = json_response(conn, 200)
      assert response_body["cep"] == "00000000"
      assert response_body["logradouro"] == "rua teste, 1"
    end

    test "when is not a valid cep", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :show, "00000000"))

      assert response_body = json_response(conn, 404)
      assert response_body == %{"error" => %{"detail" => "cep 00000000 not found"}}
    end
  end
end
