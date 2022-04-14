defmodule Tecsolfacil.Addresses.ExportAsCsvTest do
  use Tecsolfacil.DataCase
  alias Tecsolfacil.Addresses

  describe "call/0" do
    test "generate a CSV if doesn't exists registries" do
      csv = Addresses.ExportAsCsv.call()

      assert Enum.count(csv) == 1

      assert [
               "id,cep,logradouro,complemento,bairro,localidade,uf,ibge,gia,ddd,siafi,inserted_at,updated_at\n"
             ] ==
               csv
    end

    test "generate a CSV with 2 registries" do
      Addresses.create(%{cep: "00000000", logradouro: "Rua teste1"})
      Addresses.create(%{cep: "00000001", logradouro: "Rua teste2"})

      csv = Addresses.ExportAsCsv.call()

      assert Enum.count(csv) == 3
    end
  end
end
