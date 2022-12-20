require "rails_helper"

RSpec.describe "/forecast" do
  it "is routable" do
    expect(get: "/forecast").to be_routable
  end
end
