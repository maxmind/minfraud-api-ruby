module Minfraud
  module Resolver
    class << self
      def assign(context:, params:)
        Array(params).each do |key, value|
          raise RequestFormatError, "#{key} does not belong to request document format" unless MAPPING[key]

          entity = MAPPING[key].new(value) unless value.is_a?(MAPPING[key])
          context.send("#{key}=", entity || value)
        end
      end
    end

    MAPPING = {
      account:            ::Minfraud::Components::Account,
      billing:            ::Minfraud::Components::Billing,
      credit_card:        ::Minfraud::Components::CreditCard,
      device:             ::Minfraud::Components::Device,
      email:              ::Minfraud::Components::Email,
      event:              ::Minfraud::Components::Event,
      order:              ::Minfraud::Components::Order,
      payment:            ::Minfraud::Components::Payment,
      shipping:           ::Minfraud::Components::Shipping,
      shopping_cart:      ::Minfraud::Components::ShoppingCart
    }
  end
end
