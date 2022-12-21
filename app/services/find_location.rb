require "dry-initializer"

class FindLocation
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

  # TODO: I'd like to extract the lookup results from this service object, which
  # _performs_ the lookups. This would allow me to add a null-object for failed
  # lookups, with a much simpler implementation that adheres to the same
  # interface.
  def coordinates
    results = fetch_results

    return [] if results.empty?

    results.first.coordinates
  end

  private

  def query
    @query || "Cupertino"
  end

  def fetch_results
    @_results ||= geocoder.search(query)
  end
end
