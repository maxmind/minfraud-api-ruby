module Minfraud
  module Components
    class Shipping < Addressable
      include ::Minfraud::Enum
      # @attribute delivery_speed
      # @return [String] The shipping delivery speed for the order. The valid values are:
      enum_accessor :delivery_speed, [:same_day, :overnight, :expedited, :standard]

      # Creates Minfraud::Components::Shipping instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Shipping] Shipping instance
      def initialize(params = {})
        self.delivery_speed = params[:delivery_speed]
        super
      end
    end
  end
end
