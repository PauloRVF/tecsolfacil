defmodule TecsolfacilWeb.Api.V1.AddressViewTest do
  use TecsolfacilWeb.ConnCase, async: true
  alias TecsolfacilWeb.Api.V1.AddressView

  describe "render/2" do
    test "when renderize a valid address" do
      address = %{
        cep: "00000000",
        logradouro: "rua teste, 1",
        complemento: "complemento",
        bairro: "bairro",
        localidade: "localidade",
        uf: "uf",
        ibge: "ibge",
        gia: "gia",
        ddd: "ddd",
        siafi: "siafi"
      }

      return = AddressView.render("address.json", address: address)

      assert return == address
    end

    test "when renderize an error 404" do
      assert AddressView.render("404.json", cep: "00000000") == %{
               error: %{detail: "cep 00000000 not found"}
             }
    end
  end
end
