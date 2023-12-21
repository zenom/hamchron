defmodule TimeComponent do
  @moduledoc """
  Loads up the time component. This is all handled via javascript
  and probably could be a regular component vs a live component.
  """
  use HamchronWeb, :html

  def render(assigns) do
    ~H"""
    <div class="justify-right text-right" phx-hook="SetTime" id="SetTime">
      <div id="utc_time" class="portrait:text-4xl portrait:mt-1"/>
      <div class="portrait:hidden text-base text-center tracking-widest">
        <div id="local_time" />
      </div>
    </div>
    """
  end
end
