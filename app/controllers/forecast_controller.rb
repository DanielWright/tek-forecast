class ForecastController < ApplicationController
  def fetch
    head :bad_request and return if lookup.invalid?

    render json: { current: "52F" }, status: :ok
  end

  private

  def lookup
    @_lookup ||= ForecastLookup.new(query: params[:q])
  end
end
