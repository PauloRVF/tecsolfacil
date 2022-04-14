defmodule Tecsolfacil.CepWs.Client do

  @moduledoc """
    Port for cep_ws consume, juts have a function that passing a cep returns the data from the chosen adapter
  """
  @callback request(atom(), String.t()) :: {:ok, any()} | {:error, any()}

  @doc """
    Search for cep on the WS
  """
  @spec get_cep(binary()) :: {:ok, map()} | {:error, any()}
  def get_cep(cep) do
    :get
    |> get_adapter().request(cep)
    |> handle_result()
  end

  defp handle_result({:ok, %{status: 200, body: body}}), do: {:ok, body}
  defp handle_result({:error, %{status: 404}}), do: {:error, :not_found}
  defp handle_result({:error, %{status: 400}}), do: {:error, :bad_request}
  defp handle_result({:error, reason}), do: {:error, reason}

  defp get_adapter, do: Application.get_env(:tecsolfacil, :cepws_adapter)
end
