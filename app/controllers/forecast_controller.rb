class ForecastController < ApplicationController
  def fetch
    render json: { current: "52F" }, status: :ok
  end
end
