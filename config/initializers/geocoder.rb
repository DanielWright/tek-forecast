require "geocoder"

# The global Geocoder object is injected, but configured here. For the purposes
# of this app, the geocoder selected is the free, fair-use Photon API.
Geocoder.configure(
  lookup: :photon,
  cache: Geocoder::CacheStore::Generic.new(Rails.cache, {})
)
