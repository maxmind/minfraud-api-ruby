# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Reason for the IP risk.
    #
    # This class provides both a machine-readable code and a human-readable
    # explanation of the reason for the IP risk score.
    #
    # Although more codes may be added in the future, the current codes are:
    #
    # * ANONYMOUS_IP - The IP address belongs to an anonymous network. See the
    #   object at ip_address.traits for more details.
    # * BILLING_POSTAL_VELOCITY - Many different billing postal codes have been
    #   seen on this IP address.
    # * EMAIL_VELOCITY - Many different email addresses have been seen on this
    #   IP address.
    # * HIGH_RISK_DEVICE - A high risk device was seen on this IP address.
    # * HIGH_RISK_EMAIL - A high risk email address was seen on this IP address
    #   in your past transactions.
    # * ISSUER_ID_NUMBER_VELOCITY - Many different issuer ID numbers have been
    #   seen on this IP address.
    # * MINFRAUD_NETWORK_ACTIVITY - Suspicious activity has been seen on this
    #   IP address across minFraud customers.
    class IPRiskReason < Abstract
      # This value is a machine-readable code identifying the reason.
      #
      # @return [String, nil]
      attr_reader :code

      # This field provides a human-readable explanation of the reason. The
      # text may change at any time and should not be matched against.
      #
      # @return [String, nil]
      attr_reader :reason

      # @!visibility private
      def initialize(record)
        super(record)

        @code   = get('code')
        @reason = get('reason')
      end
    end
  end
end
