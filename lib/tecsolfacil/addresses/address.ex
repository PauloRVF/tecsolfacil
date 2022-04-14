defmodule Tecsolfacil.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    Address schema
  """

  @fields ~w/cep logradouro complemento bairro localidade uf ibge gia ddd siafi/a
  schema "addresses" do
    field :cep, :string
    field :logradouro, :string
    field :complemento, :string
    field :bairro, :string
    field :localidade, :string
    field :uf, :string
    field :ibge, :string
    field :gia, :string
    field :ddd, :string
    field :siafi, :string

    timestamps()
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, @fields)
    |> validate_cep()
  end

  defp validate_cep(changeset) do
    changeset
    |> validate_required([:cep])
    |> sanitize_cep()
    |> validate_length(:cep, is: 8, message: "The field CEP must have 8 numeric digits")
    |> unsafe_validate_unique(:cep, Tecsolfacil.Repo)
    |> unique_constraint(:cep)
  end

  defp sanitize_cep(changeset) do
    cep = get_change(changeset, :cep)

    if cep do
      changeset
      |> put_change(:cep, String.replace(cep, ~r/[^\d]/, ""))
    else
      changeset
    end
  end
end
