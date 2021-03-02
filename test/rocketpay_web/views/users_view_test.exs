defmodule RocketpayWeb.UsersViewTest do
  use  RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}

  test "renders create.json" do
    params = %{
      name: "Jocelino",
      password: "123456",
      nickname: "jocelino",
      email: "netojocelino@github.com",
      age: 24
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      Rocketpay.create_user(params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)

    expected_response =  %{
        message: "User created",
        user: %{
          account: %{
            balance: Decimal.new("0.00"),
            id: account_id
          },
          id: user_id,
          name: "Jocelino",
          nickname: "jocelino"
        }
      }

    assert expected_response == response
  end

end
