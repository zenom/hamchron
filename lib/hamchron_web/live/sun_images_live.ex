defmodule HamchronWeb.SunImageComponent do
  @moduledoc """
  Responsible for the images of the sun that come from
  NASA.  
  """
  use HamchronWeb, :live_component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign(:last_updated, DateTime.utc_now())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="hidden 2xl:block justify-between flex flex-wrap text-white bg-black/20 rounded-bl-lg w-64 p-2 relative">
        <div class="pt-2">
          <img
            src="https://umbra.nascom.nasa.gov/images/latest_aia_304.gif"
            class="w-28 h-28 rounded-2xl"
            id="304"
          />
        </div>
        <div class="pt-2">
          <img
            src="https://umbra.nascom.nasa.gov/images/latest_aia_171.gif"
            class="w-28 h-28 rounded-2xl"
            id="171"
          />
        </div>
        <div class="pt-2">
          <img
            src="https://umbra.nascom.nasa.gov/images/latest_aia_193.gif"
            class="w-28 h-28 rounded-2xl"
            id="193"
          />
        </div>
        <div class="pt-2">
          <img
            src="https://umbra.nascom.nasa.gov/images/latest_aia_211.gif"
            class="w-28 h-28 rounded-2xl"
            id="211"
          />
        </div>
        <div class="w-full text-xs text-white/20 pt-1 text-center">
          <%= @last_updated %>
        </div>
      </div>
    </div>
    """
  end
end
