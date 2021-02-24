defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string

      # Adicionar insertedAd e updatedAt
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end

  # Caso seja necessario especificar algo no momendo de subir a migration e no rollback
  # def up do end
  # def down do end
end
