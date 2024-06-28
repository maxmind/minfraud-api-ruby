# frozen_string_literal: true

require 'minfraud/model/billing_address'
require 'minfraud/model/credit_card'
require 'minfraud/model/device'
require 'minfraud/model/email'
require 'minfraud/model/ip_address'
require 'minfraud/model/phone'
require 'minfraud/model/score'
require 'minfraud/model/shipping_address'

module Minfraud
  module Model
    # Model of the Insights response.
    class Insights < Score
      # An object containing minFraud data related to the billing address used
      # in the transaction.
      #
      # @return [Minfraud::Model::BillingAddress]
      attr_reader :billing_address

      # An object containing minFraud data related to the billing phone
      # number used in the transaction.
      #
      # @return [Minfraud::Model::Phone]
      attr_reader :billing_phone

      # An object containing minFraud data about the credit card used in the
      # transaction.
      #
      # @return [Minfraud::Model::CreditCard]
      attr_reader :credit_card

      # This object contains information about the device that MaxMind believes
      # is associated with the IP address passed in the request.
      #
      # @return [Minfraud::Model::Device]
      attr_reader :device

      # This object contains information about the email address passed in the
      # request.
      #
      # @return [Minfraud::Model::Email]
      attr_reader :email

      # An object containing GeoIP2 and minFraud Insights information about the
      # geolocated IP address.
      #
      # @return [Minfraud::Model::IPAddress]
      attr_reader :ip_address

      # An object containing minFraud data related to the shipping address used
      # in the transaction.
      #
      # @return [Minfraud::Model::ShippingAddress]
      attr_reader :shipping_address

      # An object containing minFraud data related to the shipping phone
      # number used in the transaction.
      #
      # @return [Minfraud::Model::Phone]
      attr_reader :shipping_phone

      # @!visibility private
      def initialize(record, locales)
        super

        @billing_address  = Minfraud::Model::BillingAddress.new(
          get('billing_address')
        )
        @billing_phone    = Minfraud::Model::Phone.new(get('billing_phone'))
        @credit_card      = Minfraud::Model::CreditCard.new(get('credit_card'))
        @device           = Minfraud::Model::Device.new(get('device'))
        @email            = Minfraud::Model::Email.new(get('email'))
        @ip_address       = Minfraud::Model::IPAddress.new(get('ip_address'), locales)
        @shipping_address = Minfraud::Model::ShippingAddress.new(
          get('shipping_address')
        )
        @shipping_phone   = Minfraud::Model::Phone.new(get('shipping_phone'))
      end
    end
  end
end
