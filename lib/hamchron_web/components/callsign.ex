defmodule Callsign do
  use HamchronWeb, :html

  def info(assigns) do
    ~H"""
    <div class="text-xl align-middle h-full lg:text-6xl text-slate-300/60">
      <%= @callsign %>
      <div class="text-base justify-center text-center">
        <%= @ip_address %>
      </div>
    </div>
    """
  end
end
