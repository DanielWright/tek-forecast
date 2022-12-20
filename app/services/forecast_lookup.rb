require "dry-initializer"

class ForecastLookup
  extend Dry::Initializer

  option :query, default: proc { "Cupertino" }

  def valid?
    query != "gobbledegook"
  end

  def invalid?
    !valid?
  end
end
