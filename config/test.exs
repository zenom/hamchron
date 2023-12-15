import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
# config :hamchron, Hamchron.Repo,
#   database: Path.expand("../sqlite_app_test.db", Path.dirname(__ENV__.file)),
#   pool_size: 5,
#   pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hamchron, HamchronWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A/qJRcNNohIrf5mcY1hod8PrDaLhlEYFM0s7+RQyfTXnJ/pCoV2YWnuyGAVdr5Sn",
  server: false

# In test we don't send emails.
# config :hamchron, Hamchron.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
