defmodule Callsign do
  use HamchronWeb, :html

  def info(assigns) do
    ~H"""
    <div class="text-5xl px-8 align-middle h-full lg:px-5 lg:text-9xl text-slate-300/60">
      <%= @callsign %>
      <div class="text-base justify-center text-center">
        <%= @ip_address %>
      </div>
    </div>
    """
  end
end
