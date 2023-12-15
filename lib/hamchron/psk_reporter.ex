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
      case get("https://retrieve.pskreporter.info/query") do
        {:ok, %{status_code: 200, body: body}} ->
          parsed_result = PskInfoProcessor.process(body)
          Phoenix.PubSub.broadcast(Hamchron.PubSub, "spots_updated", {:spots, parsed_result})
          {:ok, body}

        {:ok, %{status_code: status_code, body: _body}} ->
          # Handle other status codes or responses accordingly
          {:error, "Unexpected response: #{status_code}"}

        {:error, reason} ->
          # Handle the HTTP request error
          {:error, reason}
      end
    end)
  end
end
