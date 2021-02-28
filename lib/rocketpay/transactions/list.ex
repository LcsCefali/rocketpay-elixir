defmodule Rocketpay.Transaction.List do
  alias Ecto.Repo
  alias Rocketpay.{User, Repo, Account}

  def call(params) do
    # Ecto Multi muito usado no mercado mas n tao comentado em cursos
    # Usado para fazer em apenas uma transacao do banco o que for necessario
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
      |> account_changeset()
      |> repo.insert()
  end

  defp preload_data(repo, user), do: {:ok, repo.preload(user, :account)}

  defp account_changeset(user_id), do: Account.changeset(%{user_id: user_id, balance: "0.00"})

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
