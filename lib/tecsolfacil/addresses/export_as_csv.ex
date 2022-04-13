defmodule Tecsolfacil.Addresses.ExportAsCsv do
  alias Tecsolfacil.Addresses

  @doc """
  Export all address from database to a CSV file
  """
  @spec call(binary()) :: atom() | {atom(), atom()}
  def call(filename) do
    get_addresses()
    |> parse_as_csv_string()
    |> string_as_file(filename)
  end

  defp get_addresses() do
    Addresses.list_all()
  end

  defp parse_as_csv_string(address_list) do
    headers = "id,cep,logradouro,complemento,bairro,localidade,uf,ibge,gia,ddd,siafi,inserted_at,updated_at\n"

    lines =
      Enum.map(address_list, fn e ->
        """
        "#{e.id}","#{e.cep}","#{e.logradouro}","#{e.complemento}","#{e.bairro}","#{e.localidade}",\
        "#{e.uf}","#{e.ibge}","#{e.gia}","#{e.ddd}","#{e.siafi}","#{e.inserted_at}","#{e.updated_at}"
        """
      end)

    [headers] ++ lines
  end

  defp string_as_file(content, filename) do
    File.write(filename, content)
  end
end
