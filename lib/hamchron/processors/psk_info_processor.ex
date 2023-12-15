defmodule Hamchron.Processors.PskInfoProcessor do
  import SweetXml

  @ham_bands %{
    "160 Meters" => 1_800_000..2_000_000,
    "80 Meters" => 3_500_000..4_000_000,
    "60 Meters" => 5_300_000..5_405_000,
    "40 Meters" => 7_000_000..7_300_000,
    "30 Meters" => 10_100_000..10_150_000,
    "20 Meters" => 14_000_000..14_350_000,
    "17 Meters" => 18_068_000..18_168_000,
    "15 Meters" => 21_000_000..21_450_000,
    "12 Meters" => 24_890_000..24_990_000,
    "10 Meters" => 28_000_000..29_700_000,
    "6 Meters" => 50_000_000..54_000_000,
    "2 Meters" => 144_000_000..148_000_000,
    "1.25 Meters" => 222_000_000..225_000_000,
    "70 Centimeters" => 420_000_000..450_000_000,
    "33 Centimeters" => 902_000_000..928_000_000
  }

  def process(result) do
    data = SweetXml.xpath(result, ~x"//receptionReports/activeReceiver"l)

    Enum.map(data, fn spot ->
      callsign = spot |> SweetXml.xpath(~x"./@callsign"s)
      locator = spot |> SweetXml.xpath(~x"./@locator"s)
      mode = spot |> SweetXml.xpath(~x"./@mode"s)
      frequency = spot |> SweetXml.xpath(~x"./@frequency"s)

      location =
        case GridConverter.convert(locator) do
          {:ok, latitude, longitude} ->
            [latitude, longitude, callsign, bandName(frequency), mode]

          {:error, _} ->
            {}
        end

      location
    end)
  end

  def bandName(frequency_string) do
    case frequency_string |> Integer.parse() do
      {frequency, ""} ->
        result = @ham_bands |> Enum.find(fn {_label, range} -> frequency in range end)

        case result do
          {label, _} -> label
          _ -> frequency_string
        end

      _ ->
        frequency_string
    end
  end
end
