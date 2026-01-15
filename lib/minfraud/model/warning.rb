# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Warning about the minFraud request.
    #
    # Although more codes may be added in the future, the current warning codes
    # are:
    #
    # * BILLING_CITY_NOT_FOUND - the billing city could not be found in our
    #   database.
    # * BILLING_COUNTRY_MISSING - billing address information was provided
    #   without providing a billing country.
    # * BILLING_COUNTRY_NOT_FOUND - the billing country could not be found in
    #   our database.
    # * BILLING_POSTAL_NOT_FOUND - the billing postal could not be found in our
    #   database.
    # * BILLING_REGION_NOT_FOUND - the billing region could not be found in our
    #   database.
    # * EMAIL_ADDRESS_UNUSABLE - the email address entered is likely incorrect
    #   due to an integration issue. To avoid false positives, it has not been
    #   used in scoring.
    # * INPUT_INVALID - the value associated with the key does not meet the
    #   required constraints, e.g., "United States" in a field that requires a
    #   two-letter country code.
    # * INPUT_UNKNOWN - an unknown key was encountered in the request body.
    # * IP_ADDRESS_INVALID - the IP address supplied is not a valid IPv4 or
    #   IPv6 address.
    # * IP_ADDRESS_NOT_FOUND - the IP address could not be geolocated.
    # * IP_ADDRESS_RESERVED - the IP address supplied is in a reserved
    #   network.
    # * SHIPPING_CITY_NOT_FOUND - the shipping city could not be found in our
    #   database.
    # * SHIPPING_COUNTRY_MISSING - shipping address information was provided
    #   without providing a shipping country.
    # * SHIPPING_COUNTRY_NOT_FOUND - the shipping country could not be found in
    #   our database.
    # * SHIPPING_POSTAL_NOT_FOUND - the shipping postal could not be found in
    #   our database.
    # * SHIPPING_REGION_NOT_FOUND - the shipping region could not be found in
    #   our database.
    class Warning < Abstract
      # This value is a machine-readable code identifying the warning.
      #
      # @return [String]
      attr_reader :code

      # This property provides a human-readable explanation of the warning. The
      # description may change at any time and should not be matched against.
      #
      # @return [String]
      attr_reader :warning

      # A JSON Pointer to the input field that the warning is associated with.
      # For instance, if the warning was about the billing city, this would be
      # '/billing/city'. If it was for the price in the second shopping cart
      # item, it would be '/shopping_cart/1/price'.
      #
      # @return [String, nil]
      attr_reader :input_pointer

      # @!visibility private
      def initialize(record)
        super

        @code          = get('code')
        @warning       = get('warning')
        @input_pointer = get('input_pointer')
      end
    end
  end
end
