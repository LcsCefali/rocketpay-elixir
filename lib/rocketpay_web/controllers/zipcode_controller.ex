defmodule RocketpayWeb.ZipcodeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Zipcode

  def index(conn, %{"zipcode" => zipcode}) do
    zipcode
    |> Zipcode.get_address_by_zipcode()
    |> handle_response(conn)
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
    |> put_status(:ok)
    |> json(%{data: result})
  end

  defp handle_response({:error, reason}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(reason)
  end
end
