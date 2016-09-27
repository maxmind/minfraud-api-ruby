module Minfraud
  module Components
    class Shipping < Addressable
      attr_accessor :delivery_speed

      def initialize(params = {})
        @delivery_speed = params[:delivery_speed]
        super
      end
    end
  end
end
