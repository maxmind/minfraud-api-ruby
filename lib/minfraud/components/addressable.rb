# frozen_string_literal: true

module Minfraud
  module Components
    # This is a parent class for the Billing and Shipping components.
    class Addressable < Base
      # The first name of the end user as provided in their billing / shipping
      # information.
      #
      # @return [String, nil]
      attr_accessor :first_name

      # The last name of the end user as provided in their billing / shipping
      # information.
      #
      # @return [String, nil]
      attr_accessor :last_name

      # The company of the end user as provided in their billing / shipping
      # information.
      #
      # @return [String, nil]
      attr_accessor :company

      # The first line of the user's billing / shipping address.
      #
      # @return [String, nil]
      attr_accessor :address

      # The second line of the user's billing / shipping address.
      #
      # @return [String, nil]
      attr_accessor :address_2

      # The city of the user's billing / shipping address.
      #
      # @return [String, nil]
      attr_accessor :city

      # The ISO 3166-2 subdivision code for the user's billing / shipping
      # address.
      #
      # @see https://en.wikipedia.org/wiki/ISO_3166-2
      #
      # @return [String, nil]
      attr_accessor :region

      # The two character ISO 3166-1 alpha-2 country code of the user's billing
      # / shipping address.
      #
      # @see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # @return [String, nil]
      attr_accessor :country

      # The postal code of the user's billing / shipping address.
      #
      # @return [String, nil]
      attr_accessor :postal

      # The phone number without the country code for the user's billing /
      # shipping address. Punctuation characters will be stripped. After
      # stripping punctuation characters, the number must contain only digits.
      #
      # @return [String, nil]
      attr_accessor :phone_number

      # The country code for the phone number associated with the user's
      # billing / shipping address. If you provide this information then you
      # must provide at least one digit.
      #
      # @return [String, nil]
      attr_accessor :phone_country_code

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @first_name         = params[:first_name]
        @last_name          = params[:last_name]
        @company            = params[:company]
        @address            = params[:address]
        @address_2          = params[:address_2]
        @city               = params[:city]
        @region             = params[:region]
        @country            = params[:country]
        @postal             = params[:postal]
        @phone_number       = params[:phone_number]
        @phone_country_code = params[:phone_country_code]
      end
    end
  end
end
