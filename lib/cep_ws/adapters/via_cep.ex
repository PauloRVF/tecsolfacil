defmodule Tecsolfacil.CepWs.Adapters.ViaCep do
  alias Plug.Conn.Status

  @behaviour Tecsolfacil.CepWs.Client
  @base_url "https://viacep.com.br/ws/"

  def request(method, resource) do
    method
    |> Finch.build(@base_url <> resource <> "/json")
    |> Finch.request(:finch)
    |> handle_result()
  end

  defp handle_result({:ok, %{status: 200, body: body}}) do
    body = Jason.decode!(body)

    if Map.get(body, "erro") do
      {:error, %{body: body, status: 404}}
    else
      {:ok, %{body: body, status: 200}}
    end
  end

  defp handle_result({:ok, %{status: status}}),
    do: {:error, %{reason: Status.reason_phrase(status), status: status}}

  defp handle_result({:error, reason}), do: {:error, %{reason: inspect(reason)}}
end
