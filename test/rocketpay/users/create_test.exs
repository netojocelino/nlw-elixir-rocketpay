defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, return an user" do
      # create a struct with user data
      params = %{
        name: "Jocelino",
        password: "123456",
        nickname: "jocelino",
        email: "netojocelino@github.com",
        age: 24
      }

      # create a register on test database
      {:ok, %User{ id: user_id }} = Create.call(params)

      # retrieve the register from database
      user = Repo.get(User, user_id)

      # check if data are same
      # ^ pin operator -> fix the data on attribute
      assert %User{name: "Jocelino", age: 24, id: ^user_id} = user
    end

    test "when there are invalid params, return error" do
      # create a struct with user data
      params = %{
        name: "Jocelino",
        nickname: "jocelino",
        email: "netojocelino@github.com",
        age: 2
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }


      assert errors_on(changeset) == expected_response
    end
  end

end
