class ForecastController < ApplicationController
  def fetch
    head :bad_request and return if forecast.invalid?

    render json: { current: "52F" }, status: :ok
  end

  private

  def forecast
    @_forecast ||= Forecast.lookup(query: params[:q])
  end
end
