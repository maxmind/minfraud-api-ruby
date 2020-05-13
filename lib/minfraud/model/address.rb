# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Abstract model for a postal address.
    class Address < Abstract
      # The distance in kilometers from the address to the IP location.
      #
      # @return [Integer, nil]
      attr_reader :distance_to_ip_location

      # This property is true if the address is in the IP country. The property
      # is false when the address is not in the IP country. If the address
      # could not be parsed or was not provided or if the IP address could not
      # be geolocated, the property will be nil.
      #
      # @return [Boolean, nil]
      attr_reader :is_in_ip_country

      # This property is true if the postal code provided with the address is
      # in the city for the address. The property is false when the postal code
      # is not in the city. If the address was not provided or could not be
      # parsed, the property will be nil.
      #
      # @return [Boolean, nil]
      attr_reader :is_postal_in_city

      # The latitude associated with the address.
      #
      # @return [Float, nil]
      attr_reader :latitude

      # The longitude associated with the address.
      #
      # @return [Float, nil]
      attr_reader :longitude

      # @!visibility private
      def initialize(record)
        super(record)

        @distance_to_ip_location = get('distance_to_ip_location')
        @is_in_ip_country = get('is_in_ip_country')
        @is_postal_in_city = get('is_postal_in_city')
        @latitude = get('latitude')
        @longitude = get('longitude')
      end
    end
  end
end
