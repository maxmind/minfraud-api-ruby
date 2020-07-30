# frozen_string_literal: true

module Minfraud
  # Resolver provides functionality for setting component attributes.
  module Resolver
    class << self
      # Set keys on the context based on the provided parameters.
      #
      # @param context [Object] An object for variable assignment.
      #
      # @param params [Hash] A hash of parameters.
      #
      # @return [Array]
      #
      # @raise [Minfraud::RequestFormatError] If an unexpected key is found.
      def assign(context, params)
        Array(params).each do |key, value|
          raise RequestFormatError, "#{key} does not belong to request document format" unless MAPPING[key]

          entity = MAPPING[key].new(value) unless value.is_a?(MAPPING[key])
          context.send("#{key}=", entity || value)
        end
      end
    end

    # @!visibility private
    MAPPING = {
      account:       ::Minfraud::Components::Account,
      billing:       ::Minfraud::Components::Billing,
      credit_card:   ::Minfraud::Components::CreditCard,
      custom_inputs: ::Minfraud::Components::CustomInputs,
      device:        ::Minfraud::Components::Device,
      email:         ::Minfraud::Components::Email,
      event:         ::Minfraud::Components::Event,
      order:         ::Minfraud::Components::Order,
      payment:       ::Minfraud::Components::Payment,
      shipping:      ::Minfraud::Components::Shipping,
      shopping_cart: ::Minfraud::Components::ShoppingCart,
    }.freeze
  end
end
