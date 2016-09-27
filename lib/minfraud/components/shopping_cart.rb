module Minfraud
  module Components
    class ShoppingCart < Base
      attr_accessor :items

      def initialize(params = {})
        @items = params.map(&method(:resolve))
      end

      def to_json
        @items.map(&:to_json)
      end

      private

      def resolve(params)
        ShoppingCartItem.new(params)
      end
    end
  end
end
