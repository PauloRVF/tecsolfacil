defmodule TecsolfacilWeb.Api.V1.AddressController do
  use TecsolfacilWeb, :controller
  alias Tecsolfacil.Addresses

  def show(conn, %{"cep" => cep} = _params) do
    case Addresses.SearchByCep.call(cep) do
      {:ok, address} ->
        render(conn, "address.json", address: address)

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> render("404.json", cep: cep)

      {:error, :bad_request} ->
        conn
        |> put_status(:bad_request)
        |> render("400.json")
    end
  end
end
