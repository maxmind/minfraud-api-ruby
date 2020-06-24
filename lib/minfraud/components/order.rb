# frozen_string_literal: true

module Minfraud
  module Components
    class Order < Base
      # @attribute amount
      # @return [Decimal] The total order amount for the transaction
      attr_accessor :amount

      # @attribute currency
      # @return [String] The ISO 4217 currency code for the currency used in the transaction
      attr_accessor :currency

      # @attribute discount_code
      # @return [String] The discount code applied to the transaction. If multiple discount codes are used,
      # please separate them with a comma.
      attr_accessor :discount_code

      # @attribute affiliate_id
      # @return [String] The ID of the affiliate where the order is coming from
      attr_accessor :affiliate_id

      # @attribute subaffiliate_id
      # @return [String] The ID of the sub-affiliate where the order is coming from
      attr_accessor :subaffiliate_id

      # @attribute :referrer_uri
      # @return [String] The URI of the referring site for this order
      attr_accessor :referrer_uri

      # @attribute :is_gift
      # @return [Boolean] Whether order was marked as a gift by the purchaser
      attr_accessor :is_gift

      # @attribute :has_gift_message
      # @return [Boolean] Whether the purchaser included a gift message
      attr_accessor :has_gift_message

      # Creates Minfraud::Components::Order instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Order] an Order instance
      def initialize(params = {})
        @amount           = params[:amount]
        @has_gift_message = params[:has_gift_message]
        @affiliate_id     = params[:affiliate_id]
        @subaffiliate_id  = params[:subaffiliate_id]
        @currency         = params[:currency]
        @discount_code    = params[:discount_cide]
        @referrer_uri     = params[:referrer_uri]
        @is_gift          = params[:is_gift]
      end
    end
  end
end
