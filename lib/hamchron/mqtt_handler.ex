defmodule Hamchron.MqttHandler do
  use Tortoise.Handler

  def init(args) do
    {:ok, args}
  end

  def connection(_client_id, state), do: {:ok, state}
  
  def disconnect(_client_id, _reason, state), do: {:ok, state}

  def handle_message(_topic, payload, state) do
    contact = Jason.decode(payload)
    {:ok, %{"b" => band, "md" => mode, "sc" => sender, "sl" => sender_grid}} = contact
    {:ok, latitude, longitude} = GridConverter.convert(sender_grid)
    parsed_result = %{band: band, mode: mode, sender: sender, grid: sender_grid, lat: latitude, lon: longitude}

    # IO.inspect(parsed_result)
    Phoenix.PubSub.broadcast(Hamchron.PubSub, "new_spot", {:new_spot, parsed_result})
    # IO.inspect(info)

    # IO.inspect(band)
    # IO.inspect(mode)
    # IO.inspect(sender)
    # IO.inspect(sender_grid)
    #
    # IO.inspect(GridConverter.convert(sender_grid))
    # {"sq": sequence, "f": frequency} = payload
    # IO.puts(frequency)
    {:ok, state}
  end
  
end
