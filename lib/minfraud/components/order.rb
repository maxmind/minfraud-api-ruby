# frozen_string_literal: true

module Minfraud
  module Components
    # Order corresponds to the order object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Order_(/order)
    class Order < Base
      include Minfraud::Validates

      # The total order amount for the transaction before taxes and discounts.
      # The value must be at least 0 and at most 1e14 - 1.
      #
      # @return [Float, nil]
      attr_accessor :amount

      # The ISO 4217 currency code for the currency used in the transaction.
      #
      # @see https://en.wikipedia.org/wiki/ISO_4217
      #
      # @return [String, nil]
      attr_accessor :currency

      # The discount code applied to the transaction. If multiple discount
      # codes are used, please separate them with a comma.
      #
      # @return [String, nil]
      attr_accessor :discount_code

      # The ID of the affiliate where the order is coming from. No specific
      # format is required.
      #
      # @return [String, nil]
      attr_accessor :affiliate_id

      # The ID of the sub-affiliate where the order is coming from. No specific
      # format is required.
      #
      # @return [String, nil]
      attr_accessor :subaffiliate_id

      # The URI of the referring site for this order. Needs to be absolute and
      # have a URI scheme such as +https://+.
      #
      # @return [String, nil]
      attr_accessor :referrer_uri

      # Whether order was marked as a gift by the purchaser.
      #
      # @return [Boolean, nil]
      attr_accessor :is_gift

      # Whether the purchaser included a gift message.
      #
      # @return [Boolean, nil]
      attr_accessor :has_gift_message

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @amount           = params[:amount]
        @has_gift_message = params[:has_gift_message]
        @affiliate_id     = params[:affiliate_id]
        @subaffiliate_id  = params[:subaffiliate_id]
        @currency         = params[:currency]
        @discount_code    = params[:discount_code]
        @referrer_uri     = params[:referrer_uri]
        @is_gift          = params[:is_gift]

        validate
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_zero_or_positive_number('amount', @amount)
        validate_boolean('has_gift_message', @has_gift_message)
        validate_string('affiliate_id', 255, @affiliate_id)
        validate_string('subaffiliate_id', 255, @subaffiliate_id)
        validate_regex('currency', /\A[A-Z]{3}\z/, @currency)
        validate_string('discount_code', 255, @discount_code)
        validate_uri('referrer_uri', @referrer_uri)
        validate_boolean('is_gift', @is_gift)
      end
    end
  end
end
