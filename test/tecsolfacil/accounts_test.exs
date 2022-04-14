defmodule Tecsolfacil.AccountsTest do
  use Tecsolfacil.DataCase
  alias Tecsolfacil.Accounts
  alias Tecsolfacil.Accounts.User

  @valid_user %{username: "admin", password: "My53cR37P455"}

  describe "user_create/1" do
    test "success when valid attributes" do
      assert {:ok, %User{} = user} = Accounts.user_create(@valid_user)
      assert user.username == "admin"
    end

    test "fails when is invalid input username or email" do
      assert {:error, _} = Accounts.user_create(%{password: "My53cR37P455"})
      assert {:error, _} = Accounts.user_create(%{username: "admin"})
      assert {:error, _} = Accounts.user_create(%{username: "adm", password: "My53cR37P455"})
      assert {:error, _} = Accounts.user_create(%{username: "admin", password: "My5"})
    end

    test "fails when username already exists" do
      Accounts.user_create(@valid_user)
      assert {:error, error} = Accounts.user_create(@valid_user)
      assert %{errors: [username: {"has already been taken", _}]} = error
    end
  end

  describe "user_get_by_id/1" do
    test "success when user exists" do
      {:ok, %{id: id}} = Accounts.user_create(@valid_user)

      assert user = Accounts.user_get_by_id(id)
      assert %User{} = user
      assert "admin" = user.username
    end

    test "fails when user not exists" do
      assert nil == Accounts.user_get_by_id(123)
    end
  end

  describe "user_get_by_username_and_password/2" do
    test "success when user authenticate" do
      Accounts.user_create(@valid_user)

      assert user = Accounts.user_get_by_username_and_password("admin", "My53cR37P455")
      assert %User{} = user
      assert "admin" = user.username
    end

    test "fails when user not authenticate" do
      Accounts.user_create(@valid_user)

      assert nil == Accounts.user_get_by_username_and_password("invalid_user", "invalid_pass")
    end
  end
end
