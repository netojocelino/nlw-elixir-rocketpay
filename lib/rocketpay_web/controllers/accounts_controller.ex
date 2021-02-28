defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      connection
        |> put_status(:ok)
        |> render("update.json", account: account)

    end
  end

  def withdraw(connection, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      connection
        |> put_status(:ok)
        |> render("update.json", account: account)

    end
  end

  def transaction(connection, params) do
    # Task.start(fn -> IO.puts("Transação foi realizada.") end)
    # task = Task.async(fn ->IO.puts("Aguardando finalizar...") end)
    # result_transaction = Task.await(task)

    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      connection
        |> put_status(:ok)
        |> render("transaction.json", transaction: transaction)
    end
  end

end
