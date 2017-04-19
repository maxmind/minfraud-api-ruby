module Minfraud
  module Components
    class ShoppingCartItem < Base
      # @attribute category
      # @return [String] The category of the item
      attr_accessor :category

      # @attribute item_id
      # @return [String] The internal ID of the item
      attr_accessor :item_id

      # @attribute quantity
      # @return [Integer] The quantity of the item in the shopping cart
      attr_accessor :quantity

      # @attribute price
      # @return [Float] The per-unit price of this item in the shopping cart. This should use the same currency as the order currency
      attr_accessor :price
    end
  end
end
