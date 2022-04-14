defmodule Tecsolfacil.CepWs.Adapters.ViaCepTest do
  use ExUnit.Case, async: true
  alias Tecsolfacil.CepWs.Adapters.ViaCep

  describe "request/2" do

    @tag :integration
    test "when is a valid cep" do
      assert {:ok, response_content} = ViaCep.request(:get, "05014000")
      assert 200 == response_content.status
      assert "perdizes" == String.downcase(response_content.body["bairro"])
      assert "05014-000" == response_content.body["cep"]
    end

    @tag :integration
    test "when is a invalid cep" do
      assert {:error, response_content} = ViaCep.request(:get, "AAAAAA")
      assert 400 == response_content.status
    end

    @tag :integration
    test "when is a not founded cep" do
      assert {:error, response_content} = ViaCep.request(:get, "05014999")
      assert 404 == response_content.status
    end

    @tag :integration
    test "when returns some error" do
      assert {:error, %{reason: _}} = ViaCep.request(:get, ~s/"05014999"/)
    end
  end
end
