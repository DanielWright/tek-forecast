class Location < Dry::Struct
  attribute :latitude, Types::Float
  attribute :longitude, Types::Float

  def valid?
    true
  end

  def invalid?
    false
  end

  def coordinates
    [latitude, longitude]
  end
end
