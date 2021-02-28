defmodule RocketpayWeb.TransactionsView do
  def render("transactions.json", %{
    transaction: %{from_account: from_account, to_account: to_account}
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
