require 'dry-struct'

class CurrentWeather < Dry::Struct
  attribute :weathercode, Types::Integer
  attribute :temperature, Types::Float
  attribute :timestamp, Types::Integer.default { DateTime.now.to_i }

  def to_hash
    {
      weathercode: weathercode,
      temperature: temperature,
      timestamp: timestamp.to_i
    }
  end
end
