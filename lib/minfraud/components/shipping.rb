# frozen_string_literal: true

module Minfraud
  module Components
    # Shipping corresponds to the shipping object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Shipping_(/shipping)
    class Shipping < Addressable
      include ::Minfraud::Enum

      # The shipping delivery speed for the order. Must be one of +:same_day+,
      # +:overnight+, +:expedited+, or +:standard+.
      #
      # @!attribute delivery_speed
      #
      # @return [Symbol, nil]
      enum_accessor :delivery_speed, [:same_day, :overnight, :expedited, :standard]

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        self.delivery_speed = params[:delivery_speed]
        super
      end
    end
  end
end
