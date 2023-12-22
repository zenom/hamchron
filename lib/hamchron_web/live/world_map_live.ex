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
      <div class="h-full w-full z-0 text-center align-middle pt-10" phx-hook="QsoMap" id="world-map">
        <div class="pt-10 text-3xl xl:text-7xl">
          ... loading map ...
        </div>
      </div>
    </div>
    """
  end
end
