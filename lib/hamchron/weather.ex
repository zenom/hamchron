defmodule Hamchron.Weather do
  @moduledoc """
  Get the space weather from hamqsl, process it with `Hamchron.Processors.Weather`
  and then broadcast the result to the "weather_updated" channel. It will write
  the data to weather.dat.
  """
  require Logger
  use HTTPoison.Base
  alias Hamchron.Processors.Weather

  def async_fetch_data() do
    Logger.info("Fetching Weather info...")

    Task.start_link(fn ->
      case get("https://www.hamqsl.com/solarxml.php") do
        {:ok, %{status_code: 200, body: body}} ->
          parsed_result = Weather.process(body)
          Logger.info("Weather data has been saved.")
          File.write!("/data/weather.dat", :erlang.term_to_binary(parsed_result))
          Phoenix.PubSub.broadcast(Hamchron.PubSub, "weather_updated", {:weather, parsed_result})
          {:ok, body}

        {:ok, %{status_code: status_code, body: _body}} ->
          {:error, "Unexpected response: #{status_code}"}

        {:error, reason} ->
          # Handle the HTTP request error
          {:error, reason}
      end
    end)
  end

  def sync_fetch() do 
    case get("https://www.hamqsl.com/solarxml.php") do
      {:ok, %{status_code: 200, body: body}} ->
        parsed_result = Weather.process(body)
        Logger.info("Weather data has been saved.")
        File.write!("/data/weather.dat", :erlang.term_to_binary(parsed_result))
        Phoenix.PubSub.broadcast(Hamchron.PubSub, "weather_updated", {:weather, parsed_result})
        {:ok, body}

      {:ok, %{status_code: status_code, body: _body}} ->
        {:error, "Unexpected response: #{status_code}"}

      {:error, reason} ->
        # Handle the HTTP request error
        {:error, reason}
    end
  end
end
