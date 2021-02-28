defmodule Rocketpay.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table :transactions do
      add :account_id_to, references(:accounts, type: :binary_id)
      add :account_id_from, references(:accounts, type: :binary_id)
      add :value, :decimal
      add :visible_to_friends, :boolean

      timestamps()
    end
  end
end
