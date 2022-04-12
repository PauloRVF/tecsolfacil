defmodule Tecsolfacil.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> validate_length(:cep, is: 8, message: "The field CEP must have 8 digits")
    |> validate_format(:cep, ~r/[\d]+$/, message: "Only allowed numbers for CEP")
    |> unsafe_validate_unique(:cep, Tecsolfacil.Repo)
    |> unique_constraint(:cep)
  end
end
