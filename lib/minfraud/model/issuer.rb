# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model containing information about the card issuer.
    class Issuer < Abstract
      # The name of the bank which issued the credit card.
      #
      # @return [String, nil]
      attr_reader :name

      # This property is true if the name matches the name provided in the
      # request for the card issuer. It is false if the name does not match.
      # The property is nil if either no name or issuer ID number (IIN) was
      # provided in the request or if MaxMind does not have a name associated
      # with the IIN.
      #
      # @return [Boolean, nil]
      attr_reader :matches_provided_name

      # This property is true if the phone number matches the number provided
      # in the request for the card issuer. It is false if the number does not
      # match. It is nil if either no phone number was provided or issuer ID
      # number (IIN) was provided in the request or if MaxMind does not have a
      # phone number associated with the IIN.
      #
      # @return [Boolean, nil]
      attr_reader :matches_provided_phone_number

      # The phone number of the bank which issued the credit card. In some
      # cases the phone number we return may be out of date.
      #
      # @return [String, nil]
      attr_reader :phone_number

      # @!visibility private
      def initialize(record)
        super

        @name                          = get('name')
        @phone_number                  = get('phone_number')
        @matches_provided_name         = get('matches_provided_name')
        @matches_provided_phone_number = get('matches_provided_phone_number')
      end
    end
  end
end
