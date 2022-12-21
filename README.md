# Weather Forecast API

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/DanielWright/tek-forecast/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/DanielWright/tek-forecast/tree/main)

This repo comprises a simple weather-forecast API, which first geocodes a search
parameter to a set of latitude and longitude coordinates, then uses those
coordinates to retrieve the current weather. Forecast results for a set of
coordinates are cached for 30 minutes.

## Toolchain

- Ruby 3.1.3
- Rails 7.0.x
- memcached (production only)

## Setting Up

To hack on the application locally, first clone the repository to your local environment, then `bundle install` to install gem dependencies.

To start the server: `bin/rails c`
To run the test suite: `bin/rspec`

## External Dependencies

### Geocoding

The API integrates the [Geocoder](http://www.rubygeocoder.com/) gem to provide
an interface for geocoding the provided search parameters. The gem itself
provides [numerous
adapters](https://github.com/alexreisner/geocoder/blob/master/README_API_GUIDE.md)
to different geocoding services. The API here is current configured to perform
lookups using the free, fair-use [Photon](https://photon.komoot.io/) API based
on OpenStreetMaps data.

### Weather
The API performs weather-forecast lookups against the free, fair-use [Open-Meteo
API](https://open-meteo.com/en).


## Deployment

The API is currently deployed to Heroku. Please contact me if you'd like access
to the existing deployment. Otherwise, it's trivial to provision another
instance. The only addon required is a
[MemCachier](https://elements.heroku.com/addons/memcachier) instance, such that
the `MEMCACHIER_SERVERS`, `MEMCACHIER_USERNAME`, and `MEMCACHIER_PASSWORD`
environment variables are set.

## Testing

A small RSpec test suite is included, with request specs covering most
use-cases, and unit tests for important behaviour.
