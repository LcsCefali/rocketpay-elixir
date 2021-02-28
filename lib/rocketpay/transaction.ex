defmodule Rocketpay.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rocketpay.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_params [:value, :visible_to_friends, :account_id_from, :account_id_to]

  schema "transactions" do
    field :value, :decimal
    field :visible_to_friends, :boolean
    field :account_id_from, :binary_id
    field :account_id_to, :binary_id
    belongs_to :account, Account

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
