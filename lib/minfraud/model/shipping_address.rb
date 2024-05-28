# frozen_string_literal: true

require 'minfraud/model/address'

module Minfraud
  module Model
    # Model containing information about the shipping address.
    class ShippingAddress < Address
      # The distance in kilometers from the shipping address to billing
      # address.
      #
      # @return [Integer, nil]
      attr_reader :distance_to_billing_address

      # This field is true if the shipping address is an address associated
      # with fraudulent transactions. The field is false when the address is
      # not associated with increased risk. The key will only be present when a
      # shipping address is provided.
      attr_reader :is_high_risk

      # @!visibility private
      def initialize(record)
        super

        @distance_to_billing_address = get('distance_to_billing_address')
        @is_high_risk                = get('is_high_risk')
      end
    end
  end
end
