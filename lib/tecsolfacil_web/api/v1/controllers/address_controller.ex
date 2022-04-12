defmodule TecsolfacilWeb.Api.V1.AddressController do
  use TecsolfacilWeb, :controller
  alias Tecsolfacil.Addresses

  def show(conn, %{"cep" => cep} = _params) do
    if address = Addresses.get_by_cep(cep) do
      render(conn, "address.json", address: address)
    else
      conn
      |> put_status(:not_found)
      |> render("404.json", cep: cep)
    end
  end
end
