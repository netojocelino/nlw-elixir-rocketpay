defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{
      account: %Account{
          id: account_id,
          balance: balance
        }
    }) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end


  def render("transaction.json", %{
        transaction: %TransactionResponse{
          source_account: withdraw_account,
          destination_account: deposit_account
       }
    }
  )
  do
    %{
      message: "Transaction done successfully",
      transaction: %{
        source_account: %{
          id: withdraw_account.id,
          balance: withdraw_account.balance
        },
        destination_account: %{
          id: deposit_account.id,
          balance: deposit_account.balance
        }
      }
    }

  end
end
