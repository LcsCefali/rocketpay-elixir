defmodule Rocketpay.Accounts.Transaction.Response do
  alias Rocketpay.Account
  defstruct [:from_account, :to_account, :visible_to_friends]

  def build(%Account{} = from_account, %Account{} = to_account) do
    %__MODULE__{
      from_account: from_account,
      to_account: to_account
    }
  end
end
