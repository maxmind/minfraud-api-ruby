module Minfraud
  module Components
    class ShoppingCart < Base
      # @attribute items
      # @return [Array] An array of Minfraud::Components::ShoppingCartItem instances

      attr_accessor :items
      # Creates Minfraud::Components::ShoppingCart instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::ShoppingCart] ShoppingCart instance
      def initialize(params = {})
        @items = params.map(&method(:resolve))
      end

      # @return [Array] a JSON representation of Minfraud::Components::ShoppingCart items
      def to_json
        @items.map(&:to_json)
      end

      private

      # @param  [Hash] params hash of parameters for Minfraud::Components::ShoppingCartItem
      # @return [Minfraud::Components::ShoppingCart] ShoppingCart instance
      def resolve(params)
        ShoppingCartItem.new(params)
      end
    end
  end
end
