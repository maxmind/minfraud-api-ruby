# frozen_string_literal: true

module Minfraud
  module Components
    # ShoppingCartItem corresponds to objects in the shopping_cart object
    # of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Shopping_Cart_Item
    class ShoppingCartItem < Base
      # The category of the item. This can also be a hashed value; see link.
      #
      # @see https://dev.maxmind.com/minfraud/#cart-hashing
      #
      # @return [String, nil]
      attr_accessor :category

      # The internal ID of the item. This can also be a hashed value; see link.
      #
      # @see https://dev.maxmind.com/minfraud/#cart-hashing
      #
      # @return [String, nil]
      attr_accessor :item_id

      # The quantity of the item in the shopping cart. The value must be at
      # least 0, at most 10^13-1, and have no fractional part.
      #
      # @return [Integer, nil]
      attr_accessor :quantity

      # The per-unit price of this item in the shopping cart. This should use
      # the same currency as the order currency. The value must be at least 0
      # and at most 1e14 - 1.
      #
      # @return [Float, nil]
      attr_accessor :price

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @category = params[:category]
        @item_id  = params[:item_id]
        @quantity = params[:quantity]
        @price    = params[:price]
      end
    end
  end
end
