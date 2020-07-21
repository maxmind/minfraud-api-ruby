# frozen_string_literal: true

module Minfraud
  module Components
    class Event < Base
      include ::Minfraud::Enum

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
      # 3339 date-time format. If this field is not in the request, the current
      # time will be used.
      #
      # @return [String, nil]
      attr_accessor :time

      # The type of event being scored. This must be one of
      # +:account_creation+, +:account_login+, +:email_change+,
      # +:password_reset+, +:payout_change+, +:purchase+,
      # +:recurring_purchase+, +:referral+, or +:survey+.
      #
      # @!attribute type
      #
      # @return [Symbol, nil]
      enum_accessor :type,
                    [
                      :account_creation,
                      :account_login,
                      :email_change,
                      :password_reset,
                      :payout_change,
                      :purchase,
                      :recurring_purchase,
                      :referral,
                      :survey,
                    ]

      # @param params [Hash] Hash of parameters.
      def initialize(params = {})
        @transaction_id = params[:transaction_id]
        @shop_id        = params[:shop_id]
        @time           = params[:time]
        self.type       = params[:type]
      end
    end
  end
end
