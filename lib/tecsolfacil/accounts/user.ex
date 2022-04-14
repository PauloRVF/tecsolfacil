defmodule Tecsolfacil.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    User schema
  """

  @fields ~w/username password password_hash/a
  schema "users" do
    field :username, :string
    field :password, :string, redact: true
    field :pasword_hash, :string

    timestamps()
  end

  def changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, @fields)
    |> validate_username()
    |> validate_password(opts)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_required([:username])
    |> validate_length(:password, min: 4, max: 30)
    |> unsafe_validate_unique(:username, Plugfacil.Repo)
    |> unique_constraint(:username)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 30)
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> validate_length(:password, max: 30, count: :bytes)
      |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end
end
