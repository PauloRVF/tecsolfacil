defmodule Tecsolfacil.AddressesTest do
  use Tecsolfacil.DataCase
  alias Tecsolfacil.Addresses
  alias Tecsolfacil.Addresses.Address

  @valid_address %{cep: "00000000", logradouro: "rua teste, 1"}

  describe "create/1" do
    test "success when valid attributes" do
      assert {:ok, %Address{} = address} = Addresses.create(@valid_address)
      assert address.cep == "00000000"
    end

    test "fails when is a nil cep" do
      assert {:error, _} = Addresses.create(%{})
      assert {:error, _} = Addresses.create(%{cep: nil})
    end

    test "fails when is a invalid formatted cep" do
      assert {:error, _} = Addresses.create(%{cep: "aaaaaaaa"})
      assert {:error, _} = Addresses.create(%{cep: "1234567"})
    end
  end

  describe "list_all/0" do
    test "success when list all addresses" do
      Addresses.create(%{cep: "00000000", logradouro: "rua teste, 1"})
      Addresses.create(%{cep: "00000001", logradouro: "rua teste, 2"})

      addresses = Addresses.list_all()

      assert Enum.count(addresses) == 2
      for address <- addresses do
        assert %Address{} = address
      end
    end
  end

  describe "get_by_id/1" do
    test "success when address exists" do
      {:ok, %{id: id}} = Addresses.create(@valid_address)

      assert address = Addresses.get_by_id(id)
      assert %Address{} = address
      assert "rua teste, 1" = address.logradouro
      assert "00000000" = address.cep
    end

    test "fails when address not exists" do
      assert nil == Addresses.get_by_id(123)
    end
  end

  describe "get_by_cep/1" do
    test "success when address exists" do
      {:ok, %{cep: cep}} = Addresses.create(@valid_address)

      assert address = Addresses.get_by_cep(cep)
      assert %Address{} = address
      assert "rua teste, 1" = address.logradouro
      assert "00000000" = address.cep
    end

    test "fails when address not exists" do
      assert nil == Addresses.get_by_cep("00000001")
    end
  end

  describe "update/2" do
    test "success when address has been updated" do
      {:ok, old_address} = Addresses.create(@valid_address)

      assert {:ok, address} =
               Addresses.update(old_address, %{
                 cep: "00000001",
                 logradouro: "rua teste atualizada, 1"
               })

      assert %Address{} = address
      assert "rua teste atualizada, 1" = address.logradouro
      assert "00000001" = address.cep
    end

    test "fails when trying to update with invalid formatted cep" do
      {:ok, old_address} = Addresses.create(@valid_address)

      assert {:error, _} = Addresses.update(old_address, %{cep: "aaaaaaaa"})
      assert {:error, _} = Addresses.update(old_address, %{cep: "1234567"})
    end
  end
end
