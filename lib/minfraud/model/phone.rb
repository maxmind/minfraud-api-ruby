# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model with information about the billing or shipping phone number.
    class Phone < Abstract
      # The two-character ISO 3166-1 country code for the country associated
      # with the phone number.
      #
      # @return [String, nil]
      attr_reader :country

      # This is true if the phone number is a Voice over Internet Protocol
      # (VoIP) number allocated by a regulator. It is false if the phone
      # number is not a VoIP number allocated by a regulator. The attribute
      # is nil when a valid phone number has not been provided or we do not
      # have data for the phone number.
      #
      # @return [Boolean, nil]
      attr_reader :is_voip

      # This property is true if the phone number's prefix is commonly
      # associated with the postal code. It is false if the prefix is not
      # associated with the postal code. It is non-nil only when the phone
      # number is in the US, the number prefix is in our database, and the
      # postal code and country are provided in the request.
      #
      # @return [Boolean, nil]
      attr_reader :matches_postal

      # The name of the original network operator associated with the phone
      # number. This attribute does not reflect phone numbers that have been
      # ported from the original operator to another, nor does it identify
      # mobile virtual network operators.
      #
      # @return [String, nil]
      attr_reader :network_operator

      # One of the following values: fixed or mobile. Additional values may
      # be added in the future.
      #
      # @return [String, nil]
      attr_reader :number_type

      # @!visibility private
      def initialize(record)
        super

        @country          = get('country')
        @is_voip          = get('is_voip')
        @matches_postal   = get('matches_postal')
        @network_operator = get('network_operator')
        @number_type      = get('number_type')
      end
    end
  end
end
