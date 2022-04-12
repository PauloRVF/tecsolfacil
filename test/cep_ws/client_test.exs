defmodule Tecsolfacil.CepWs.ClientTest do
  use ExUnit.Case
  alias Tecsolfacil.CepWs.Adapters.Mock, as: CepWsMock
  alias Tecsolfacil.CepWs.Client

  describe "get_cep/1" do
    test "when is a valid cep returns 200" do
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

      assert {:ok, %{} = response_body} = Client.get_cep("00000000")
      assert response_body["bairro"] == "bairro"
      assert response_body["cep"] == "00000-000"
    end

    test "when is not found" do
      expected_body = %{"erro" => "true"}

      Hammox.expect(CepWsMock, :request, fn _method, _endpoint ->
        {:error, :not_found}
      end)

      assert {:error, :not_found} = Client.get_cep("00000001")
    end

    test "when is not a valid formatted cep" do
      Hammox.expect(CepWsMock, :request, fn _method, _endpoint ->
        {:error, %{status: 400}}
      end)

      assert {:error, :bad_request} = Client.get_cep("AAAAAAAA")
    end
  end
end
