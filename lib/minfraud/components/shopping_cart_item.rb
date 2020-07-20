# frozen_string_literal: true

module Minfraud
  module Components
    class ShoppingCartItem < Base
      # The category of the item.
      #
      # @return [String, nil]
      attr_accessor :category

      # The internal ID of the item.
      #
      # @return [String, nil]
      attr_accessor :item_id

      # The quantity of the item in the shopping cart.
      #
      # @return [Integer, nil]
      attr_accessor :quantity

      # The per-unit price of this item in the shopping cart. This should use
      # the same currency as the order currency.
      #
      # @return [Float, nil]
      attr_accessor :price

      # @param params [Hash] Hash of parameters.
      def initialize(params = {})
        @category = params[:category]
        @item_id  = params[:item_id]
        @quantity = params[:quantity]
        @price    = params[:price]
      end
    end
  end
end
