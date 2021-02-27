defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:source_account, :destination_account]

  def build(%Account{} = source_account, %Account{} = destination_account) do
    %__MODULE__{
      source_account: source_account,
      destination_account: destination_account
    }
  end
end
