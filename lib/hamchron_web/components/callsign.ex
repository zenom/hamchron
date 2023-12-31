defmodule Callsign do
  use HamchronWeb, :html

  def info(assigns) do
    ~H"""
    <div class="text-2xl mt-1 landscape:mt-2 align-middle h-full md:portrait:mt-2 md:portrait:text-5xl lg:landscape:mt-3 xl:landscape:mt-5 lg:text-6xl xl:text-7xl 2xl:text-8xl 2xl:mb-5 2xl:pl-2 text-slate-300/60">
      <%= @callsign %>
      <div class="text-base justify-center text-center">
        <%= @ip_address %>
      </div>
    </div>
    """
  end
end
