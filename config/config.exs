# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# config :hamchron,
#   ecto_repos: [Hamchron.Repo],
#   generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :hamchron, HamchronWeb.Endpoint,
  url: [host: "localhost"],
  # http: [ip: {0, 0, 0, 0}, port: 4000],
  # adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: HamchronWeb.ErrorHTML, json: HamchronWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Hamchron.PubSub,
  live_view: [signing_salt: "kOc11ykU"]

config :hamchron, Hamchron.Schedule,
  jobs: [
    {"@hourly", {Hamchron.Weather, :async_fetch_data, []}}
  ]

# Tortoise.Supervisor.start_child(
#     client_id: "hamchron",
#     handler: {Tortoise.Handler.Logger, []},
#     server: {Tortoise.Transport.Tcp, host: 'mqtt.pskreporter.info', port: 1883},
#     subscriptions: [{"psk/filter/v2", 0}])

# config :hamchron, Hamchron.MqttClient,
#   server: {Tortoise.Transport.Tcp, host: "mqtt.pskreporter.info", port: 1886},
#   client_id: "hamchron",
#   # username: "optional_username",
#   # password: "optional_password",
#   handler: {Hamchron.MqttHandler, []},
#   subscriptions: [{"pskr/filter/v2/+/+/+/+/+/#{Application.get_env(:hamchron, :grid_square)}/+/+", 0}]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :hamchron, Hamchron.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
