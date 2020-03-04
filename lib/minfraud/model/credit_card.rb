# frozen_string_literal: true

require 'minfraud/model/abstract'
require 'minfraud/model/issuer'

module Minfraud
  module Model
    # Model with details about the credit card used.
    class CreditCard < Abstract
      # The card brand, such as "Visa", "Discover", "American Express", etc.
      #
      # @return [String, nil]
      attr_reader :brand

      # This property contains the two letter ISO 3166-1 alpha-2 country code
      # (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) associated with the
      # location of the majority of customers using this credit card as
      # determined by their billing address. In cases where the location of
      # customers is highly mixed, this defaults to the country of the bank
      # issuing the card.
      #
      # @return [String, nil]
      attr_reader :country

      # This property is true if the country of the billing address matches the
      # country of the majority of customers using this credit card. In cases
      # where the location of customers is highly mixed, the match is to the
      # country of the bank issuing the card.
      #
      # @return [Boolean, nil]
      attr_reader :is_issued_in_billing_address_country

      # This property is true if the card is a prepaid card.
      #
      # @return [Boolean, nil]
      attr_reader :is_prepaid

      # This property is true if the card is a virtual card.
      #
      # @return [Boolean, nil]
      attr_reader :is_virtual

      # An object containing information about the credit card issuer.
      #
      # @return [Minfraud::Model::Issuer]
      attr_reader :issuer

      # The card's type. The valid values are: charge, credit, debit.
      #
      # @return [String, nil]
      attr_reader :type

      # @!visibility private
      def initialize(record)
        super(record)

        @brand = get('brand')
        @country = get('country')
        @is_issued_in_billing_address_country = get(
          'is_issued_in_billing_address_country'
        )
        @is_prepaid = get('is_prepaid')
        @is_virtual = get('is_virtual')
        @issuer = Minfraud::Model::Issuer.new(get('issuer'))
        @type = get('type')
      end
    end
  end
end
