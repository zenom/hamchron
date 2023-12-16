defmodule TimeComponent do
  @moduledoc """
  Loads up the time component. This is all handled via javascript
  and probably could be a regular component vs a live component.
  """
  use HamchronWeb, :html

  def render(assigns) do
    ~H"""
    <div class="text-7xl lg:text-9xl" phx-hook="SetTime" id="SetTime">
      <div id="utc_time" />
      <div class="text-base text-center tracking-widest">
        <div id="local_time" />
      </div>
    </div>
    """
  end
end
