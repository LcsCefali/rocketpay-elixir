defmodule Rocketpay.Accounts.Transaction do
  alias Ecto.Multi
  alias Rocketpay.{Accounts.Operation, Repo, Transaction}
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

  def call(%{"from_id" => from_id, "to_id" => to_id, "value" => value, "visible_to_friends" => _visible_to_friends} = params_transaction) do
    withdraw_params = build_params(from_id, value)
    deposit_params = build_params(to_id, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> Multi.run(:transactions, fn repo, _changes -> save_transaction(repo, params_transaction) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp transaction_changeset(
    %{"from_id" => from_id, "to_id" => to_id, "value" => value, "visible_to_friends" => visible_to_friends}) do
    Transaction.changeset(%{
      account_id_from: from_id,
      account_id_to: to_id,
      value: value,
      visible_to_friends: visible_to_friends
    })
  end

  defp save_transaction(repo, params) do
    params
    |> transaction_changeset()
    |> repo.insert()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: to_account, withdraw: from_account}} ->
        {:ok, TransactionResponse.build(from_account, to_account)}
    end
  end

end
