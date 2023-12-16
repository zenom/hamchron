defmodule Hamchron.Weather.Space do
  @moduledoc """
  This only reads the weather.data file which is just a map
  of the data we get back from `Hamchron.Processors.Weather`
  """
  def latest() do
    File.read!("/data/weather.dat") |> :erlang.binary_to_term()
  end
end
