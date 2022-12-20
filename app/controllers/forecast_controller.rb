class ForecastController < ApplicationController
  def fetch
    render json: {}, status: :ok
  end
end
