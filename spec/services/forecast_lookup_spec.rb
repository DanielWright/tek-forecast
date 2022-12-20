require "spec_helper"
require_relative "../../app/services/forecast_lookup"

RSpec.describe ForecastLookup do
  let(:lookup) { described_class.new(query: q) }
  let(:q) { nil }

  describe "#valid?" do
    subject { lookup.valid? }

    context "with a nil query" do
      it { is_expected.to be_truthy }
    end

    context "with an invalid query" do
      let(:q) { "gobbledegook" }

      it { is_expected.to be_falsy }
    end
  end
end
