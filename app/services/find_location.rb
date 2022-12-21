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
