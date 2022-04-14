defmodule Tecsolfacil.Addresses.ExportAsCsv do
  alias Tecsolfacil.Addresses

  @moduledoc """
  Export all address from database to a CSV
  """

  @spec call() :: list(binary())
  def call do
    get_addresses()
    |> parse_as_csv_string()
  end

  defp get_addresses do
    Addresses.list_all()
  end

  defp parse_as_csv_string(address_list) do
    headers =
      "id,cep,logradouro,complemento,bairro,localidade,uf,ibge,gia,ddd,siafi,inserted_at,updated_at\n"

    lines =
      Enum.map(address_list, fn e ->
        """
        "#{e.id}","#{e.cep}","#{e.logradouro}","#{e.complemento}","#{e.bairro}","#{e.localidade}",\
        "#{e.uf}","#{e.ibge}","#{e.gia}","#{e.ddd}","#{e.siafi}","#{e.inserted_at}","#{e.updated_at}"
        """
      end)

    [headers] ++ lines
  end
end
