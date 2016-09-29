module Minfraud
  module Components
    class Payment < Base
      # @attribute processor
      # @return [String] The payment processor used for the transaction
      attr_accessor :processor

      # @attribute was_authorized
      # @return [Boolean] The authorization outcome from the payment processor. If the transaction has not yet been approved or denied, do not include this field
      attr_accessor :was_authorized

      # @attribute decline_code
      # @return [String] The decline code as provided by your payment processor. If the transaction was not declined, do not include this field
      attr_accessor :decline_code

      # Creates Minfraud::Components::Payment instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Payment] Payment instance
      def initialize(params = {})
        @was_authorized = params[:was_authorized]
        @decline_code   = params[:decline_code]
        @processor      = params[:processor]
      end
    end
  end
end
