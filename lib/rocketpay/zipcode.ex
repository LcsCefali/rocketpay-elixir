defmodule Rocketpay.Zipcode do
  @endpoint "https://viacep.com.br/ws"

  def get_address_by_zipcode(zipcode) do
    "#{@endpoint}/#{zipcode}/json"
    # "#{@endpoint}/AC/Rio Branco/#{zipcode}/json"
    |> HTTPoison.get()
    |> handle_address_by_zipcode()
  end

  defp handle_address_by_zipcode({:ok, result}) do
    result =
      result.body
      |> Poison.decode!()
    {:ok, %{result: result}}
  end

  defp handle_address_by_zipcode({:error, _reason}), do: {:error, %{message: "CEP informado não é válido!"}}
end
