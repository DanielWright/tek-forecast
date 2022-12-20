require "dry-initializer"

class Forecast
  extend Dry::Initializer

  option :query, default: proc { "Cupertino" }

  def self.lookup(**kwargs)
    new(**kwargs)
  end

  def valid?
    query != "gobbledegook"
  end

  def invalid?
    !valid?
  end
end
