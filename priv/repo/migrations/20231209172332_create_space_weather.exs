# defmodule Hamchron.Repo.Migrations.CreateSpaceWeather do
#   use Ecto.Migration
#
#   def change do
#     create table(:space_weather) do
#       add :source, :string
#       add :source_url, :string
#       add :updated, :string
#       add :solarflux, :integer
#       add :a_index, :integer
#       add :k_index, :integer
#       add :sunspots, :integer
#       add :solarwind, :float
#       add :geomagfield, :string
#       add :signalnoise, :string
#       add :day_12, :string
#       add :day_30, :string
#       add :day_17, :string
#       add :day_80, :string
#       add :night_12, :string
#       add :night_30, :string
#       add :night_17, :string
#       add :night_80, :string
#       add :e_skip_europe, :string
#       add :e_skip_europe_4m, :string
#       add :e_skip_europe_6m, :string
#       add :e_skip_north_america, :string
#       add :vhf_aurora_northern_hemi, :string
#
#       timestamps(type: :utc_datetime)
#     end
#   end
# end
