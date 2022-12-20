require "rails_helper"

RSpec.describe "A /forecast endpoint" do
  let(:search_query) { nil }

  subject(:forecast!) { get "/forecast", params: { q: search_query } }

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
    parsed_response = JSON.parse(response.body)

    expect(parsed_response.keys).to contain_exactly(*%w(current))
  end

  context "without a search parameter", focus: true do
    it "retrieves the forecast for Cupertino" do
      forecast!

      # FIXME: See above
      parsed_response = JSON.parse(response.body)

      expect(parsed_response.symbolize_keys).to include("current": "52F")
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

  context "with a valid set of coordinates"
  context "with a valid zipcode"
  context "with a valid address"
end
