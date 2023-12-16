defmodule Hamchron.PskReporter do
  @moduledoc """
  Fetch the latest data from PSKReporter.info.  Send it
  to `Hamchron.Processors.PskInfoProcessor` to be parsed.

  Then send the message that we have received the update along 
  with the parsed result.
  """
  require Logger
  use HTTPoison.Base
  alias Hamchron.Processors.PskInfoProcessor

  def async_fetch_data() do
    Logger.info("Fetching PSK Reporter info...")

    Task.start_link(fn ->
      grid_square = Application.get_env(:hamchron, :grid_square)
      url = "https://retrieve.pskreporter.info/query"
      Logger.info("Calling: #{url} with square: #{grid_square}")
      params = %{
        callsign: grid_square,
        modify: "grid"
      }
      case get(url, params) do
        {:ok, %{status_code: 200, body: body}} ->
          parsed_result = PskInfoProcessor.process(body)
          Phoenix.PubSub.broadcast(Hamchron.PubSub, "spots_updated", {:spots, parsed_result})
          {:ok, body}

        {:ok, %{status_code: status_code, body: body}} ->
          # Handle other status codes or responses accordingly
          IO.inspect(status_code)
          IO.inspect(body)
          {:error, "Unexpected response: #{status_code}"}

        {:error, reason} ->
          IO.inspect(reason)
          # Handle the HTTP request error
          # Logger.error("Unable to fetch data: #{reason}")
          {:error, reason}
      end
    end)
  end
end
