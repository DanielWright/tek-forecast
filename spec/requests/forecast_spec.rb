require "rails_helper"
require "support/vcr"

RSpec.describe "A /forecast endpoint", vcr: { record: :new_episodes } do

  subject(:forecast!) { get "/forecast", params: { q: search_query } }

  context "without a search parameter" do
    let(:search_query) { nil }

    it "responds 200 OK" do
      forecast!

      expect(response).to have_http_status(:ok)
    end

    it "responds with JSON" do
      forecast!

      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    # TODO: revisit JSON schema validation?
    it "conforms to an expected schema" do
      forecast!

      # FIXME: Danger! Not DRY and not permissive
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response.keys).to contain_exactly(*%i(temperature weathercode))
    end

    it "responds with the forecast for Cupertino" do
      forecast!

      # FIXME: See above
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to include(
        temperature: a_value_within(0.5).of(49)
      )
    end
  end

  context "with an invalid search parameter" do
    let(:search_query) { "gobbledegook" }

    # NOTE: There are reasonable arguments against 400 as the semantically
    # appropriate response code here, but I'd want to involve stakeholders
    # in such a decision, and 400 is a valid placeholder for the time being.
    it "responds 400 Bad Request" do
      forecast!

      expect(response).to have_http_status(:bad_request)
    end
  end

  context "with a valid zipcode" do
    let(:search_query) { "90210" }

    it "returns the current forecast for the location" do
      forecast!

      # FIXME: See above
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to include(
        temperature: a_value_within(0.5).of(52.5)
      )
    end
  end

  context "with a valid set of coordinates"
  context "with a valid address"
end
