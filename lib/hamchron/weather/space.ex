defmodule Hamchron.Weather.Space do
  # use Ecto.Schema
  # import Ecto.Changeset
  # import Ecto.Query

  # alias Hamchron.Weather.Space
  # alias Hamchron.Repo

  # schema "space_weather" do
  #   field :source, :string
  #   field :source_url, :string
  #   field :updated, :string
  #   field :solarflux, :integer
  #   field :a_index, :integer
  #   field :k_index, :integer
  #   field :sunspots, :integer
  #   field :solarwind, :float
  #   field :geomagfield, :string
  #   field :signalnoise, :string
  #   field :day_12, :string
  #   field :day_30, :string
  #   field :day_17, :string
  #   field :day_80, :string
  #   field :night_12, :string
  #   field :night_30, :string
  #   field :night_17, :string
  #   field :night_80, :string
  #   field :e_skip_europe, :string
  #   field :e_skip_europe_4m, :string
  #   field :e_skip_europe_6m, :string
  #   field :e_skip_north_america, :string
  #   field :vhf_aurora_northern_hemi, :string
  #
  #   timestamps(type: :utc_datetime)
  # end
  #
  # @doc false
  # def changeset(space, attrs) do
  #   space
  #   |> cast(attrs, [
  #     :source,
  #     :source_url,
  #     :updated,
  #     :solarflux,
  #     :a_index,
  #     :k_index,
  #     :sunspots,
  #     :solarwind,
  #     :geomagfield,
  #     :signalnoise,
  #     :day_12,
  #     :day_30,
  #     :day_17,
  #     :day_80,
  #     :night_12,
  #     :night_30,
  #     :night_17,
  #     :night_80,
  #     :e_skip_europe,
  #     :e_skip_europe_4m,
  #     :e_skip_europe_6m,
  #     :e_skip_north_america,
  #     :vhf_aurora_northern_hemi
  #   ])
  #   |> validate_required([
  #     :source,
  #     :source_url,
  #     :updated,
  #     :solarflux,
  #     :a_index,
  #     :k_index,
  #     :sunspots,
  #     :solarwind,
  #     :geomagfield,
  #     :signalnoise,
  #     :day_12,
  #     :day_30,
  #     :day_17,
  #     :day_80,
  #     :night_12,
  #     :night_30,
  #     :night_17,
  #     :night_80,
  #     :e_skip_europe,
  #     :e_skip_europe_4m,
  #     :e_skip_europe_6m,
  #     :e_skip_north_america,
  #     :vhf_aurora_northern_hemi
  #   ])
  # end

  def latest() do
    File.read!("weather.dat") |> :erlang.binary_to_term()
    # Space |> order_by(desc: :inserted_at) |> limit(1) |> Repo.one()
  end
end
