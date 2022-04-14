defmodule TecsolfacilWeb.Api.V1.AddressController do
  use TecsolfacilWeb, :controller
  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Addresses.ReportCsvByEmail

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

  def report(conn, %{"email" => email}=_params) do
    %{"email" => email}
    |> ReportCsvByEmail.new()
    |> Oban.insert()

    conn
    |> put_status(:accepted)
    |> render("202.json")
  end

  def report(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> render("400.json")
  end
end
