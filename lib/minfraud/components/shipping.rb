module Minfraud
  module Components
    class Shipping < Addressable
      extend ::Minfraud::Enum
      # @attribute delivery_speed
      # @return [String] The shipping delivery speed for the order. The valid values are:
      enum_accessor :delivery_speed, %i[
        expedited
        overnight
        same_day
        standard
      ]
    end
  end
end
