# frozen_string_literal: true

module Minfraud
  module Components
    # Event corresponds to the event object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--event
    class Event < Base
      include ::Minfraud::Enum
      include Minfraud::Validates

      # The party submitting the transaction. This must be one of +:agent+ or
      # +:customer+.
      #
      # @!attribute party
      #
      # @return [Symbol, nil]
      enum_accessor :party,
                    %i[
                      agent
                      customer
                    ]

      # Your internal ID for the transaction. MaxMind can use this to locate a
      # specific transaction in logs, and it will also show up in email alerts
      # and notifications from MaxMind to you. No specific format is required.
      #
      # @return [String, nil]
      attr_accessor :transaction_id

      # Your internal ID for the shop, affiliate, or merchant this order is
      # coming from. Required for minFraud users who are resellers, payment
      # providers, gateways and affiliate networks. No specific format is
      # required.
      #
      # @return [String, nil]
      attr_accessor :shop_id

      # The date and time the event occurred. The string must be in the RFC
      # 3339 date-time format, e.g., "2012-04-12T23:20:50.52Z". The time must
      # be within the past year. If this field is not in the request, the
      # current time will be used.
      #
      # @see https://tools.ietf.org/html/rfc3339
      #
      # @return [String, nil]
      attr_accessor :time

      # The type of event being scored. This must be one of
      # +:account_creation+, +:account_login+, +:credit_application+,
      # +:email_change+, +:fund_transfer+, +:password_reset+,
      # +:payout_change+, +:purchase+, +:recurring_purchase+, +:referral+,
      # +:sim_swap+, or +:survey+.
      #
      # @!attribute type
      #
      # @return [Symbol, nil]
      enum_accessor :type,
                    %i[
                      account_creation
                      account_login
                      credit_application
                      email_change
                      fund_transfer
                      password_reset
                      payout_change
                      purchase
                      recurring_purchase
                      referral
                      sim_swap
                      survey
                    ]

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        self.party      = params[:party]
        @transaction_id = params[:transaction_id]
        @shop_id        = params[:shop_id]
        @time           = params[:time]
        self.type       = params[:type]

        validate
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_string('transaction_id', 255, @transaction_id)
        validate_string('shop_id', 255, @shop_id)
        validate_rfc3339('time', @time)
      end
    end
  end
end
