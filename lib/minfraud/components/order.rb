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
    end
  end
end
