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
      Phoenix.PubSub.subscribe(Hamchron.PubSub, "new_spot")
    end

    # gotta be a better place to put this
    unless File.exists?('weather.dat') || File.exists?("/data/weather.dat") do 
      Hamchron.Weather.sync_fetch()
    end

    {:ok, latitude, longitude } = Application.get_env(:hamchron, :user_lat_long)

    socket =
      socket 
      |> assign(:ip_address, Application.get_env(:hamchron, :local_ip_address)) 
      |> push_event("load_map", %{map: %{latitude: latitude, longitude: longitude}})

    {:ok, socket}
  end

  def handle_info({:new_spot, detail}, socket) do 
    socket =
      socket |> push_event("new_spot", %{spot: detail})
    {:noreply, socket}
  end

  def handle_info({:weather, details}, socket) do
    send_update(SpaceWeatherComponent, id: "space-weather", details: details)
    send_update(SunspotsComponent, id: "sunspots", details: details)
    send_update(SunImageComponent, id: "sunimage")
    {:noreply, socket}
  end


  def render(assigns) do
    ~H"""
    <div class="flex w-full z-0">
      <div class="h-[calc(100vh-68px)] md:portrait:h-[calc(100vh-80px)] lg:landscape:lg:h-[calc(100vh-124px)] lg:portrait:h-[calc(100vh-84px)] xl:landscape:h-[calc(100vh-144px)] flex w-full 2xl:landscape:h-[calc(100vh-167px)] lg:relative">
        <WorldMapComponent.render />
      </div>
      <div class="invisible 2xl:visible absolute right-0 z-10 w-64 bg-slate-800/30">
        <.live_component module={SunspotsComponent} id="sunspots" />
        <.live_component module={SunImageComponent} id="sunimage" />
      </div>
    </div>
    """
  end
end
