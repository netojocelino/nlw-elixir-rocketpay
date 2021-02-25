defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  action_fallback RocketpayWeb.FallbackController

  def create(connection, params) do
    params
      |> Rocketpay.create_user()
      |> handle_response(connection)
  end

  defp handle_response({:ok, %User{} = user}, connection) do
    connection
      |> put_status(:created)
      |> render("create.json", user: user)
  end


end
