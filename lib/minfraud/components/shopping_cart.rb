# frozen_string_literal: true

module Minfraud
  module Components
    # ShoppingCart corresponds to the shopping_cart object of a minFraud
    # request.
    #
    # @see https://dev.maxmind.com/minfraud/#Shopping_Cart_(/shoppingcart)
    class ShoppingCart < Base
      # An array of Minfraud::Components::ShoppingCartItem instances.
      #
      # @return [Array<Minfraud::Components::ShoppingCartItem>]
      attr_accessor :items

      # @param params [Array] Array of shopping cart items. You may provide
      #   each item as either a Hash where each key is a symbol corresponding
      #   to an item's field, or as a Minfraud:::Components::ShoppingCartItem
      #   object.
      def initialize(params = [])
        @items = params.map(&method(:resolve))
      end

      # A JSON representation of Minfraud::Components::ShoppingCart items.
      #
      # @return [Array]
      def to_json(*_args)
        @items.map(&:to_json)
      end

      private

      def resolve(params)
        params.is_a?(ShoppingCartItem) ? params : ShoppingCartItem.new(params)
      end
    end
  end
end
