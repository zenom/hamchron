defmodule GridConverter do
  @moduledoc """
  Convert a grid square like EN82ao to it's latitude and longitude.
  
  """

  @doc """
  Takes in a grid square that is at least 6 chars and returns the latitude and longitude.

  ## Example:
    iex> GridConverter.convert("EN82ao")
    {:ok, 42.58333333333334, -84.0}

    iex(2)> GridConverter.convert("EN82")
    {:ok, 42.0, -84.0}

    iex(3)> GridConverter.convert("a")
    {:error, "unable to determine location"}
  """
  def convert(grid_square) when is_binary(grid_square) and byte_size(grid_square) >= 6 do
    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" |> String.codepoints()

    [_first, _second, _third, _fourth, fifth, sixth] =
      String.upcase(grid_square) |> String.slice(0..5) |> String.codepoints()

    {final_lat, final_lon} = base_conversion(grid_square)
    minutes_lon = Enum.find_index(letters, &(&1 == fifth)) * 5
    minutes_lat = Enum.find_index(letters, &(&1 == sixth)) * 2.5

    {:ok, convert_lat(final_lat, minutes_lat), convert_lon(final_lon, minutes_lon)}
  end

  def convert(grid_square) when is_binary(grid_square) and byte_size(grid_square) >= 4 do
    {final_lat, final_lon} = base_conversion(grid_square)

    minutes_lon = 0
    minutes_lat = 0

    {:ok, convert_lat(final_lat, minutes_lat), convert_lon(final_lon, minutes_lon)}
  end

  def convert(_grid_square) do
    {:error, "unable to determine location"}
  end

  defp base_conversion(grid_square) do
    first_letter_vals = build_ranges()
    second_letter_vals = build_ranges(10, ?A..?X)

    [first, second, third, fourth] =
      String.upcase(grid_square) |> String.slice(0..3) |> String.codepoints()

    {:ok, longitude_1} = first_letter_vals |> Map.fetch(first)
    {:ok, latitude_1} = second_letter_vals |> Map.fetch(second)

    start_lon.._ = longitude_1
    additional_lon = String.to_integer(third) * 2
    final_lon = start_lon + additional_lon

    start_lat.._ = latitude_1
    additonal_lat = String.to_integer(fourth)
    final_lat = start_lat + additonal_lat

    {final_lat, final_lon}
  end

  defp build_ranges(step \\ 20, letters \\ ?A..?R) do
    for {letter, index} <- Enum.with_index(letters) do
      {List.to_string([letter]), (index * step)..((index + 1) * step)}
    end
    |> Map.new()
  end

  defp convert_lon(longitude_deg, longitude_min)
      when is_number(longitude_deg) and is_number(longitude_min) do
    total_longitude = longitude_deg + longitude_min / 60.0

    case total_longitude do
      east when east >= 0 and east <= 180 ->
        east - 180

      west when west > 180 and west <= 360 ->
        west + 180 - 360

      _ ->
        {"Invalid Long", 0}
    end
  end

  defp convert_lat(latitude_deg, latitude_min)
      when is_number(latitude_deg) and is_number(latitude_min) do
    total_latitude = latitude_deg + latitude_min / 60.0

    case total_latitude do
      north when north >= 0 and north <= 90 ->
        north - 90

      south when south > 90 and south <= 180 ->
        south - 90

      _ ->
        {"Invalid Lat", 0}
    end
  end
end
