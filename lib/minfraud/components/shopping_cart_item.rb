module Minfraud
  module Components
    class ShoppingCartItem < Base
      attr_accessor :category
      attr_accessor :item_id
      attr_accessor :quantity
      attr_accessor :price

      def initialize(params = {})
        @category = params[:category]
        @item_id  = params[:item_id]
        @quantity = params[:quantity]
        @price    = params[:price]
      end
    end
  end
end


