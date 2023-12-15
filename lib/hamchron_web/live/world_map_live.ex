defmodule WorldMapComponent do
  @moduledoc """
  Loads the hooks for the wolrd map.  The map and data is 
  loaded in the hook and is all done in JS.
  """
  use HamchronWeb, :live_component

  def mount(socket) do
    Hamchron.PskReporter.async_fetch_data()
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full">
      <div id="data-coords" />

      <div class="h-full z-0" phx-hook="QsoMap" id="world-map">
        ... loading map ...
      </div>
    </div>
    """
  end
end
