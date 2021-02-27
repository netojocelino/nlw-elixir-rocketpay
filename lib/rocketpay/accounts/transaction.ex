defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi

  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse
  alias Rocketpay.Repo

  def call(%{"source" => source_id, "destination" => destination_id, "value" => value}) do
    withdraw_params = build_params(source_id, value)
    deposit_params = build_params(destination_id, value)

    Multi.new()
     |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
     |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
     |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _change} -> {:error, reason}
      {:ok, %{deposit: deposit_account, withdraw: withdraw_account}} -> {
        :ok,
        TransactionResponse.build(withdraw_account, deposit_account)
      }
    end
  end

end
