defmodule Tecsolfacil.Addresses do
  alias Ecto.Changeset
  alias Tecsolfacil.Addresses.Address
  alias Tecsolfacil.Repo

  @moduledoc """
    Repository module for Address schema
  """

  @doc """
    Creates an Address
  """
  @spec create(map()) :: {:ok, Endereco} | {:error, Changeset}
  def create(attrs) do
    %Address{}
    |> Address.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    List all Addresses
  """
  @spec list_all() :: [Address]
  def list_all do
    Repo.all(Address)
  end

  @doc """
    Gets a single Address filtering by id
  """
  @spec get_by_id(integer()) :: Endereco | nil
  def get_by_id(id), do: Repo.get(Address, id)

  @doc """
    Gets a single Address filtering by cep
  """
  @spec get_by_cep(binary()) :: Endereco | nil
  def get_by_cep(cep), do: Repo.get_by(Address, cep: cep)

  @doc """
   Updates an Address
  """
  @spec update(map(), map()) :: {:ok, Endereco} | {:error, Changeset}
  def update(address, attrs) do
    address
    |> Address.changeset(attrs)
    |> Repo.update()
  end
end
