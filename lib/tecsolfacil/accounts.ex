defmodule Tecsolfacil.Accounts do
  alias Ecto.Changeset
  alias Tecsolfacil.Accounts.User
  alias Tecsolfacil.Repo

  @moduledoc """
    Repository module for accounts context, schemas: [User]
  """
  @spec user_get_by_id(integer()) :: User | nil
  def user_get_by_id(id), do: Repo.get(User, id)

  @spec user_create(map()) :: {:ok, User} | {:error, Changeset}
  def user_create(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec user_get_by_username_and_password(binary(), binary()) :: User | nil
  def user_get_by_username_and_password(username, password) do
    with %{password_hash: password_hash} = user <- Repo.get_by(User, username: username),
         true <- Bcrypt.verify_pass(password, password_hash) do
      user
    else
      _ -> nil
    end
  end
end
