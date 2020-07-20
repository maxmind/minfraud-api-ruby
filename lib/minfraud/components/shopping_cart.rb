# frozen_string_literal: true

module Minfraud
  module Components
    class ShoppingCart < Base
      # An array of Minfraud::Components::ShoppingCartItem instances.
      #
      # @return [Array<Minfraud::Components::ShoppingCartItem>]
      attr_accessor :items

      # @param params [Hash] Hash of parameters.
      def initialize(params = {})
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
