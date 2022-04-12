defmodule Tecsolfacil.Addresses.SearchByCep do
  alias Tecsolfacil.Addresses
  alias Tecsolfacil.CepWs.Client

  @doc """
    Try get address from database, otherwise, try get address from a WS and persist data
  """
  def call(cep) do
    if address = get_from_database(cep) do
      {:ok, address}
    else
      cep
      |> get_from_external_ws()
      |> maybe_persist_data()
    end
  end

  defp get_from_database(cep), do: Addresses.get_by_cep(cep)

  defp get_from_external_ws(cep), do: Client.get_cep(cep)

  defp maybe_persist_data({:ok, address_data}), do: Addresses.create(address_data)
  defp maybe_persist_data(term), do: term
end
