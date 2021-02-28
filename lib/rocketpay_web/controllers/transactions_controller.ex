defmodule RocketpayWeb.TransactionsController do
  use RocketpayWeb, :controller

  action_fallback RocketpayWeb.FallbackController

  def list_transactions(conn, params) do
    with {:ok, %{} = transaction} <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
