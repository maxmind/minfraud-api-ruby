# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Score for risk factors that are used in calculating the riskScore.
    class Subscores < Abstract
      # The risk associated with the AVS result. If present, this is a value in
      # the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :avs_result

      # The risk associated with the billing address. If present, this is a
      # value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :billing_address

      # The risk associated with the distance between the billing address and
      # the location for the given IP address. If present, this is a value in
      # the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :billing_address_distance_to_ip_location

      # The risk associated with the browser attributes such as the User-Agent
      # and Accept-Language. If present, this is a value in the range 0.01 to
      # 99.
      #
      # @return [Float, nil]
      attr_reader :browser

      # Individualized risk of chargeback for the given IP address given for
      # your account and any shop ID passed. This is only available to users
      # sending chargeback data to MaxMind. If present, this is a value in the
      # range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :chargeback

      # The risk associated with the country the transaction originated from.
      # If present, this is a value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :country

      # The risk associated with the combination of IP country, card issuer
      # country, billing country, and shipping country. If present, this is a
      # value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :country_mismatch

      # The risk associated with the CVV result. If present, this is a value in
      # the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :cvv_result

      # The risk associated with the device. If present, this is a value in the
      # range of 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :device

      # The risk associated with the particular email address. If present, this
      # is a value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :email_address

      # The general risk associated with the email domain. If present, this is
      # a value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :email_domain

      # The risk associated with the email address local part (the part of
      # the email address before the @ symbol). If present, this is a value
      # in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :email_local_part

      # The risk associated with the particular issuer ID number (IIN) given
      # the billing location and the history of usage of the IIN on your
      # account and shop ID. If present, this is a value in the range 0.01 to
      # 99.
      #
      # @return [Float, nil]
      attr_reader :issuer_id_number

      # The risk associated with the particular order amount for your account
      # and shop ID. If present, this is a value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :order_amount

      # The risk associated with the particular phone number. If present, this
      # is a value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :phone_number

      # The risk associated with the shipping address. If present, this is a
      # value in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :shipping_address

      # The risk associated with the distance between the shipping address and
      # the IP location for the given IP address. If present, this is a value
      # in the range 0.01 to 99.
      #
      # @return [Float, nil]
      attr_reader :shipping_address_distance_to_ip_location

      # The risk associated with the local time of day of the transaction in
      # the IP address location. If present, this is a value in the range 0.01
      # to 99.
      #
      # @return [Float, nil]
      attr_reader :time_of_day

      # @!visibility private
      def initialize(record)
        super

        @avs_result                               = get('avs_result')
        @billing_address                          = get('billing_address')
        @billing_address_distance_to_ip_location  = get(
          'billing_address_distance_to_ip_location'
        )
        @browser                                  = get('browser')
        @chargeback                               = get('chargeback')
        @country                                  = get('country')
        @country_mismatch                         = get('country_mismatch')
        @cvv_result                               = get('cvv_result')
        @device                                   = get('device')
        @email_address                            = get('email_address')
        @email_domain                             = get('email_domain')
        @email_local_part                         = get('email_local_part')
        @issuer_id_number                         = get('issuer_id_number')
        @order_amount                             = get('order_amount')
        @phone_number                             = get('phone_number')
        @shipping_address                         = get('shipping_address')
        @shipping_address_distance_to_ip_location = get(
          'shipping_address_distance_to_ip_location'
        )
        @time_of_day                              = get('time_of_day')
      end
    end
  end
end
