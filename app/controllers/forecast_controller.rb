class ForecastController < ApplicationController
  def fetch
    head :bad_request and return if forecast.invalid?

    render json: forecast.to_json, status: :ok
  end

  private

  def forecast
    @_forecast ||= Rails.cache.fetch(location.coordinates, expires_in: 30.minutes) do
      Forecast.fetch(location: location)
    end
  end

  def location
    @_location ||= FindLocation.lookup(query: params[:q], geocoder: Geocoder)
  end
end
