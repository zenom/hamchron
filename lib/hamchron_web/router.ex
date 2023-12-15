defmodule HamchronWeb.Router do
  use HamchronWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HamchronWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HamchronWeb do
    pipe_through :browser

    live "/", ChronoLive, :home
  end

  if Application.compile_env(:hamchron, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HamchronWeb.Telemetry
    end
  end
end
