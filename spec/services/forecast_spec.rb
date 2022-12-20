require "spec_helper"
require_relative "../../app/services/forecast"

RSpec.describe Forecast do
  let(:geocoder) { double(:geocoder) }

  let(:lookup) { described_class.lookup(query: q, geocoder: geocoder) }
  let(:q) { nil }

  let(:geocoder_results) do
    [
      double(:geocoder_result, coordinates: [latitude, longitude])
    ]
  end

  let(:latitude) { -122.001 }
  let(:longitude) { 37.322 }

  before do
    allow(geocoder).to receive(:search) { geocoder_results }
  end

  describe "#valid?" do
    subject { lookup.valid? }

    context "with a nil query" do
      it { is_expected.to be_truthy }
    end

    context "with an invalid query" do
      let(:geocoder_results) { [] }

      it { is_expected.to be_falsy }
    end
  end

  describe "#coordinates" do
    context "with a valid query" do
      let(:q) { "Cupertino" }

      it "knows the geocoded coordinates for the query" do
        expect(lookup.coordinates).to contain_exactly(latitude, longitude)
      end
    end

    context "with an invalid query" do
      let(:geocoder_results) { [] }

      it "raises an exception" do
        expect(lookup.coordinates).to be_empty
      end
    end
  end
end
