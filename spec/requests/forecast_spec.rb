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
end
