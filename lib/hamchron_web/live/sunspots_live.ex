defmodule HamchronWeb.SunspotsComponent do
  @moduledoc """
  Responsible for the side bar that contains things like
  Sunspot, Solarflux, Noise etc.
  """
  use HamchronWeb, :live_component
  alias Hamchron.Weather.Space

  def update(assigns, socket) do
    weather =
      case assigns do
        %{id: "sunspots", details: details} ->
          details

        _ ->
          current_space_weather()
      end

    socket =
      socket
      |> assign(assigns)
      |> assign(:weather, weather)

    {:ok, socket}
  end

  def className(text) do
    case text |> String.downcase() do
      "band closed" ->
        "text-red-600"

      _ ->
        ""
    end
  end

  def render(assigns) do
    ~H"""
    <div class="">
      <div class="text-white bg-black/20 w-64 p-2 relative">
        <table class="table-auto w-full">
          <tr>
            <td class="text-left text-sm">Sunpots:</td>
            <td class="text-right text-sm"><%= @weather.sunspots %></td>
          </tr>
          <tr>
            <td class="text-left text-sm">Solarflux:</td>
            <td class="text-right text-sm"><%= @weather.solarflux %></td>
          </tr>
          <tr>
            <td class="text-left text-sm">Noise:</td>
            <td class="text-right text-sm"><%= @weather.signalnoise %></td>
          </tr>
          <tr>
            <td class="text-left text-sm">GeoMag Field:</td>
            <td class="text-right text-sm"><%= @weather.geomagfield %></td>
          </tr>
          <tr>
            <td class="text-left text-sm">A/K:</td>
            <td class="text-right text-sm"><%= @weather.a_index %> / <%= @weather.k_index %></td>
          </tr>
          <tr>
            <td class="text-left text-sm">Aurora:</td>
            <td class={"text-right text-sm #{className(@weather.vhf_aurora_northern_hemi)}"}>
              <%= @weather.vhf_aurora_northern_hemi %>
            </td>
          </tr>
          <tr>
            <td class="text-left text-sm">EU 2M:</td>
            <td class={"text-right text-sm #{className(@weather.e_skip_europe)}"}>
              <%= @weather.e_skip_europe %>
            </td>
          </tr>
          <tr>
            <td class="text-left text-sm">EU 4M:</td>
            <td class={"text-right text-sm #{className(@weather.e_skip_europe_4m)}"}>
              <%= @weather.e_skip_europe_4m %>
            </td>
          </tr>
          <tr>
            <td class="text-left text-sm">EU 6M:</td>
            <td class={"text-right text-sm #{className(@weather.e_skip_europe_6m)}"}>
              <%= @weather.e_skip_europe_6m %>
            </td>
          </tr>
          <tr>
            <td class="text-left text-sm">US 2M:</td>
            <td class={"text-right text-sm #{className(@weather.e_skip_north_america)}"}>
              <%= @weather.e_skip_north_america %>
            </td>
          </tr>
        </table>
      </div>
    </div>
    """
  end

  defp current_space_weather() do
    Space.latest()
  end
end
