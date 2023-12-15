defmodule SpaceWeatherComponent do
  use HamchronWeb, :live_component
  alias Hamchron.Weather.Space

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    weather =
      case assigns do
        %{id: "space-weather", details: details} ->
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
      "fair" ->
        "text-yellow-300"

      "good" ->
        "text-lime-300"

      "poor" ->
        "text-red-300"

      _ ->
        ""
    end
  end

  def render(assigns) do
    ~H"""
    <div class="flex table-auto justify-end">
      <table class="text-xs lg:text-sm">
        <thead>
          <tr>
            <td class="text-center">Band</td>
            <td class="text-center">Day</td>
            <td class="text-center">Night</td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="px-5 text-center">80M - 40M</td>
            <td class={"px-5 text-center #{className(@weather.day_80)}"}><%= @weather.day_80 %></td>
            <td class={"px-5 text-center #{className(@weather.night_80)}"}>
              <%= @weather.night_80 %>
            </td>
          </tr>
          <tr>
            <td class="px-5 text-center">30M - 20M</td>
            <td class={"px-5 text-center #{className(@weather.day_30)}"}><%= @weather.day_30 %></td>
            <td class={"px-5 text-center #{className(@weather.night_30)}"}>
              <%= @weather.night_30 %>
            </td>
          </tr>
          <tr>
            <td class="px-5 text-center">17M - 15M</td>
            <td class={"px-5 text-center #{className(@weather.day_17)}"}><%= @weather.day_17 %></td>
            <td class={"px-5 text-center #{className(@weather.night_17)}"}>
              <%= @weather.night_17 %>
            </td>
          </tr>
          <tr>
            <td class="px-5 text-center">12M - 10M</td>
            <td class={"px-5 text-center #{className(@weather.day_12)}"}><%= @weather.day_12 %></td>
            <td class={"px-5 text-center #{className(@weather.night_12)}"}>
              <%= @weather.night_12 %>
            </td>
          </tr>
          <tr>
            <td colspan="3" class="text-slate-400/50 text-right px-5 text-xs">
              (<%= @weather.updated %>) Provided by:
              <.link href={@weather.source_url}><%= @weather.source %></.link>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end

  defp current_space_weather() do
    Space.latest()
  end
end
