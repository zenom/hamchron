defmodule WorldMapComponent do
  @moduledoc """
  Loads the hooks for the wolrd map.  The map and data is 
  loaded in the hook and is all done in JS.
  """
  # use HamchronWeb, :live_component
  use HamchronWeb, :html

  def render(assigns) do
    ~H"""
    <div class="w-full">
      <div id="data-coords" />

      <div class="h-full w-full z-0 text-center align-middle pt-10 text-4xl xl:text-6xl" phx-hook="QsoMap" id="world-map">
        ... loading map ...
      </div>
    </div>
    """
  end
end
