defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Jocelino",
        password: "123456",
        nickname: "jocelino",
        email: "netojocelino@github.com",
        age: 24
      }

      {:ok, %User{account: %Account{ id: account_id }}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YWRtaW46bm90X3NlY3JldF9iYXNpY19hdXRoLnBhc3Nvd29yZA==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a deposit", %{ conn: conn, account_id: account_id } do
      params = %{ "value" => "50.0" }


      response =
        conn
          |> post(Routes.accounts_path(conn, :deposit, account_id, params))
          |> json_response(:ok)

      assert %{
                "account" => %{"balance" => "50.00", "id" => _id},
                "message" => "Balance changed successfully"
              } = response
    end


    test "when there are invalid params, returns an error", %{ conn: conn, account_id: account_id } do
      params = %{ "value" => "string" }


      response =
        conn
          |> post(Routes.accounts_path(conn, :deposit, account_id, params))
          |> json_response(:bad_request)

      expected_response = %{
        "message" => "Invalid operation value"
      }
      assert expected_response == response
    end


  end
end
