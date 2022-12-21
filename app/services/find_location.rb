require "dry-initializer"
require "dry-struct"

class FindLocation
  extend Dry::Initializer

  option :query, reader: false
  option :geocoder

  def self.lookup(**kwargs)
    new(**kwargs).fetch_results
  end

  def fetch_results
    results = geocoder.search([query, "USA"].join(","))

    return NullLocation.new if results.empty?

    lat, lng = results.first.coordinates

    Location.new \
      latitude: lat,
      longitude: lng
  end

  private

  def query
    @query || "Cupertino"
  end
end

module Types
  include Dry.Types()
end


class Location < Dry::Struct::Value
  attribute :latitude, Types::Float
  attribute :longitude, Types::Float

  def valid?
    true
  end

  def invalid?
    false
  end

  def coordinates
    [latitude, longitude]
  end
end

class NullLocation
  def coordinates
    []
  end

  def valid?
    false
  end

  def invalid?
    true
  end
end
