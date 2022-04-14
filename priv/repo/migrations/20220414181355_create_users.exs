defmodule Tecsolfacil.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string
      add :password, :string, virtual: true
      add :pasword_hash, :string

      timestamps()
    end
  end
end
