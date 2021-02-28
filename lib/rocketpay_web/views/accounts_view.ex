defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

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
        balance: balance,
      }
    }
  end

  def render("transaction.json", %{
    transaction: %TransactionResponse{from_account: from_account, to_account: to_account}
  }) do
    %{
      message: "Transaction done successfully",
      from_account: %{
        id: from_account.id,
        user_id: from_account.user_id,
        balance: from_account.balance
      },
      to_account: %{
        id: to_account.id,
        user_id: to_account.user_id,
        balance: to_account.balance
      }
    }
  end
end
