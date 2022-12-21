require "spec_helper"
require "support/vcr"
require_relative "../../app/services/forecast"

RSpec.describe Forecast, vcr: true do
  let(:forecast) do
    described_class.new(
      location: location
    )
  end

  let(:location) { double(:location, coordinates: [-11, 22]) }

  describe "#to_hash" do
    it "retrieves a Hash of the current forecast" do
      expect(forecast.to_hash).to include(
        temperature: a_value,
        weathercode: a_value
      )
    end
  end
end
