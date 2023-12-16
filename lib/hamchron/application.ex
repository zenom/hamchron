defmodule Hamchron.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    Application.put_env(:hamchron, :local_ip_address, get_ip_address())
    Application.put_env(:hamchron, :user_lat_long, user_lat_long())
    Application.put_env(:hamchron, :callsign, System.get_env("CALLSIGN") || "YOURCALL")
    Application.put_env(:hamchron, :grid_square, System.get_env("GRID_SQUARE") || "EN82ao")

    children = [
      HamchronWeb.Telemetry,
      # Hamchron.Repo,
      {DNSCluster, query: Application.get_env(:hamchron, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hamchron.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hamchron.Finch},
      # Start a worker by calling: Hamchron.Worker.start_link(arg)
      # {Hamchron.Worker, arg},
      # Start to serve requests, typically the last entry
      HamchronWeb.Endpoint,
      Hamchron.Schedule
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hamchron.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def user_lat_long() do
    GridConverter.convert(System.get_env("GRID_SQUARE") || "EN82ao")
  end

  def get_ip_address() do
    {:ok, ifs} = :inet.getif()
    ips = Enum.map(ifs, fn {ip, _broadaddr, _mask} -> ip end)
    {one, two, three, four} = ips |> List.first()
    "#{one}.#{two}.#{three}.#{four}"
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HamchronWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
