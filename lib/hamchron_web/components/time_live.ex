defmodule TimeComponent do
  @moduledoc """
  Loads up the time component. This is all handled via javascript
  and probably could be a regular component vs a live component.
  """
  use HamchronWeb, :html

  def render(assigns) do
    ~H"""
    <div class="justify-right text-right lg:landscape:text-center" phx-hook="SetTime" id="SetTime">
      <div id="utc_time" class="portrait:text-4xl portrait:mt-1 lg:landscape:text-7xl xl:mt-3 2xl:landscape:mt-0 2xl:landscape:text-9xl"/>
      <div class="portrait:hidden md:portrait:block text-base text-center tracking-widest">
        <div id="local_time" />
      </div>
    </div>
    """
  end
end
