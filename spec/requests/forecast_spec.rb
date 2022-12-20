require "rails_helper"

RSpec.describe "A /forecast endpoint" do
  it "responds 200 OK" do
    get "/forecast"

    expect(response).to have_http_status(:ok)
  end
end
