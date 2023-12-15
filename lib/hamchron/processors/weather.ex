defmodule Hamchron.Processors.Weather do
  @moduledoc """
  This takes the xml that comes in from `Hamchron.Weather.async_fetch_data`
  and builds up a map.
  """
  import SweetXml
  require Logger

  def process(body) do
    solardata = SweetXml.xpath(body, ~x"//solardata")
    source_url = solardata |> SweetXml.xpath(~x"./source/@url"s)
    source_name = solardata |> SweetXml.xpath(~x"./source/text()"s)
    updated = solardata |> SweetXml.xpath(~x"./updated/text()"s) |> String.trim()
    solarflux = solardata |> SweetXml.xpath(~x"./solarflux/text()"i)

    a_index =
      solardata
      |> SweetXml.xpath(~x"./aindex/text()"s)
      |> String.trim()
      |> String.to_integer()

    k_index =
      solardata
      |> SweetXml.xpath(~x"./kindex/text()"s)
      |> String.trim()
      |> String.to_integer()

    sunspots = solardata |> SweetXml.xpath(~x"./sunspots/text()"i)
    solarwind = solardata |> SweetXml.xpath(~x"./solarwind/text()"f)
    geomagfield = solardata |> SweetXml.xpath(~x"./geomagfield/text()"s)
    signalnoise = solardata |> SweetXml.xpath(~x"./signalnoise/text()"s)

    calculatedconditions = solardata |> SweetXml.xpath(~x"./calculatedconditions/band"l)

    calculatedvhfconditions =
      solardata |> SweetXml.xpath(~x"./calculatedvhfconditions/phenomenon"l)

    data =
      %{
        source_url: source_url,
        source: source_name,
        updated: updated,
        solarflux: solarflux,
        a_index: a_index,
        k_index: k_index,
        sunspots: sunspots,
        solarwind: solarwind,
        geomagfield: geomagfield,
        signalnoise: signalnoise
      }

    data =
      calculatedconditions
      |> Enum.reduce(data, fn condition, acc ->
        band = condition |> SweetXml.xpath(~x"./@name"s) |> String.slice(0..1)
        time = condition |> SweetXml.xpath(~x"./@time"s)
        cond = condition |> SweetXml.xpath(~x"./text()"s)

        column = "#{time}_#{band}" |> String.to_atom()
        Map.update(acc, column, cond, fn _current_cond -> cond end)
      end)

    data =
      calculatedvhfconditions
      |> Enum.reduce(data, fn condition, acc ->
        band = condition |> SweetXml.xpath(~x"./@name"s) |> String.replace("-", "_")

        location =
          condition |> SweetXml.xpath(~x"./@location"s)

        cond = condition |> SweetXml.xpath(~x"./text()"s)

        column = String.downcase("#{band}_#{location}") |> String.to_atom()
        Map.update(acc, column, cond, fn _current_cond -> cond end)
      end)

    data
  end
end
