require "dry-initializer"

class Forecast
  extend Dry::Initializer

  option :query, reader: false
  option :geocoder

  def self.lookup(**kwargs)
    new(**kwargs)
  end

  def valid?
    !invalid?
  end

  def invalid?
    coordinates.empty?
  end

  def coordinates
    results = geocoder.search(query)

    return [] if results.empty?

    results.first.coordinates
  end

  private

  def query
    @query || "Cupertino"
  end
end
