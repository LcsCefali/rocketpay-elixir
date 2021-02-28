defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.{Deposit, Withdraw, TransactionCreate}
  alias Rocketpay.Accounts.Transaction, as: TransactionCreate
  alias Rocketpay.Transaction.List, as: TransactionList

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: TransactionCreate, as: :call
  defdelegate list_transaction(params), to: TransactionList, as: :call
end
