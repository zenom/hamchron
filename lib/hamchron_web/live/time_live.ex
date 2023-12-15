defmodule TimeComponent do
  use HamchronWeb, :live_component

  def mount(socket) do
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
    <div class="text-7xl lg:text-9xl" phx-hook="SetTime" id="SetTime">
      <div id="utc_time" />
      <div class="text-base text-center tracking-widest">
        <div id="local_time" />
      </div>
    </div>
    """
  end
end
