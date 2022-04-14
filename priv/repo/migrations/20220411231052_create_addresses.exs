defmodule Tecsolfacil.Repo.Migrations.CreateEnderecos do
  use Ecto.Migration

  def change do
    create table("addresses") do
      add :cep, :string
      add :logradouro, :string
      add :complemento, :string
      add :bairro, :string
      add :localidade, :string
      add :uf, :string
      add :ibge, :string
      add :gia, :string
      add :ddd, :string
      add :siafi, :string

      timestamps()
    end
  end
end
