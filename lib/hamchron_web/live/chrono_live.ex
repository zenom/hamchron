defmodule HamchronWeb.ChronoLive do
  @moduledoc """
  Primary entrypoint for the app. 
  """
  use HamchronWeb, :live_view
  alias HamchronWeb.SunspotsComponent
  alias HamchronWeb.SunImageComponent

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Hamchron.PubSub, "weather_updated")
      Phoenix.PubSub.subscribe(Hamchron.PubSub, "spots_updated")
    end
    Hamchron.Weather.sync_fetch()

    socket =
      socket |> assign(:ip_address, get_ip_address()) |> push_event("load_map", %{map: true})

    {:ok, socket}
  end

  def handle_info({:weather, details}, socket) do
    send_update(SpaceWeatherComponent, id: "space-weather", details: details)
    send_update(SunspotsComponent, id: "sunspots", details: details)
    send_update(SunImageComponent, id: "sunimage", details: details)
    {:noreply, socket}
  end

  def handle_info({:spots, details}, socket) do
    socket =
      socket |> push_event("load_psk", %{psk: details})

    {:noreply, socket}
  end

  def get_ip_address() do
    {:ok, ifs} = :inet.getif()
    ips = Enum.map(ifs, fn {ip, _broadaddr, _mask} -> ip end)
    {one, two, three, four} = ips |> List.first()
    "#{one}.#{two}.#{three}.#{four}"
  end

  def render(assigns) do
    ~H"""
    <div class="flex w-full z-0">
      <div class="flex w-full h-[calc(100vh-168px)] lg:relative">
        <.live_component module={WorldMapComponent} id="world-map" />
      </div>
      <div class="absolute right-0 z-10 w-64 bg-slate-800/30">
        <.live_component module={SunspotsComponent} id="sunspots" />
        <.live_component module={SunImageComponent} id="sunimage" />
      </div>
    </div>
    """
  end
end