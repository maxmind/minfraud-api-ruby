module Minfraud
  module Components
    class Addressable < Base
      # @attribute first_name
      # @return [String] The first name of the end user as provided in their billing / shipping information
      attr_accessor :first_name

      # @attribute last_name
      # @return [String] The last name of the end user as provided in their billing / shipping information
      attr_accessor :last_name

      # @attribute company
      # @return [String] The company of the end user as provided in their billing / shipping information
      attr_accessor :company

      # @attribute address
      # @return [String] The first line of the user's billing / shipping address
      attr_accessor :address

      # @attribute address_2
      # @return [String] The second line of the user's billing / shipping address
      attr_accessor :address_2

      # @attribute city
      # @return [String] The city of the user's billing / shipping address
      attr_accessor :city

      # @attribute region
      # @return [String] The ISO 3166-2 subdivision code for the user's billing / shipping address
      attr_accessor :region

      # @attribute country
      # @return [String] The two character ISO 3166-1 alpha-2 country code of the user's billing / shipping address
      attr_accessor :country

      # @attribute postal
      # @return [String] The postal code of the user's billing / shipping address
      attr_accessor :postal

      # @attribute phone_number
      # @return [String] The phone number without the country code for the user's billing / shipping address
      attr_accessor :phone_number

      # @attribute phone_country_code
      # @return [String] The country code for phone number associated with the user's billing / shipping address
      attr_accessor :phone_country_code
    end
  end
end
