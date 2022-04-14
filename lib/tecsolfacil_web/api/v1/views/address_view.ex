defmodule TecsolfacilWeb.Api.V1.AddressView do
  use TecsolfacilWeb, :view

  def render("address.json", %{address: address}) do
    %{
      cep: address.cep,
      logradouro: address.logradouro,
      complemento: address.complemento,
      bairro: address.bairro,
      localidade: address.localidade,
      uf: address.uf,
      ibge: address.ibge,
      gia: address.gia,
      ddd: address.ddd,
      siafi: address.siafi
    }
  end

  def render("404.json", %{cep: cep}) do
    %{error: %{detail: "cep #{cep} not found"}}
  end

  def render("400.json", _) do
    %{error: %{detail: "bad request"}}
  end

  def render("202.json", _) do
    %{status: "accepted, processing request"}
  end
end
