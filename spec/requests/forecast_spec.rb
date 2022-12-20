require "rails_helper"

RSpec.describe "A /forecast endpoint" do
  subject(:forecast!) { get "/forecast" }

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

  context "with an invalid search parameter"
  context "with a valid set of coordinates"
  context "with a valid zipcode"
  context "with a valid address"
end
