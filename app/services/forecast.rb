require "dry-initializer"
require "dry-struct"
require "faraday"

# TODO: Move me
module Types
  include Dry.Types()
end

class Forecast
  extend Dry::Initializer
  extend Forwardable

  option :location

  BASE_FORECAST_LOOKUP_URL = "https://api.open-meteo.com".freeze

  def self.fetch(**kwargs)
    new(**kwargs)
  end

  def to_hash
    fetch.to_hash
  end

  def to_json
    to_hash.to_json
  end

  private

  def_delegators :location, :invalid?, :valid?

  def http_client
    Faraday.new(url: BASE_FORECAST_LOOKUP_URL)
  end

  def fetch
    response = http_client.get(
      "/v1/forecast",
      {
        latitude: location.coordinates[0],
        longitude: location.coordinates[1],
        current_weather: true,
        temperature_unit: "fahrenheit"
      }
    )

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    CurrentWeather.new(parsed_body[:current_weather]).to_hash
  end

  class CurrentWeather < Dry::Struct::Value
    attribute :weathercode, Types::Integer
    attribute :temperature, Types::Float

    def to_hash
      {
        weathercode: weathercode,
        temperature: temperature
      }
    end
  end
end
