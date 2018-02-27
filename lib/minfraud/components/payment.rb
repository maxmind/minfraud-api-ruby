module Minfraud
  module Components
    class Payment < Base
      include ::Minfraud::Enum
      # @attribute processor
      # @return [String] The payment processor used for the transaction
      enum_accessor :processor, [
        :adyen, :altapay, :amazon_payments, :american_express_payment_gateway, :authorizenet, :balanced, :beanstream, 
        :bluepay, :bluesnap, :bpoint, :braintree, :ccnow, :chase_paymentech, :checkout_com, :cielo, :collector, :commdoo, 
        :compropago, :concept_payments, :conekta, :cuentadigital, :curopayments, :cybersource, :dalpay, :dibs, 
        :digital_river, :ebs, :ecomm365, :elavon, :emerchantpay, :epay, :eprocessing_network, :eway, :exact, :first_data, 
        :global_payments, :heartland, :hipay, :ingenico, :internetsecure, :intuit_quickbooks_payments, :iugu, :lemon_way, 
        :mastercard_payment_gateway, :mercadopago, :merchant_esolutions, :mirjeh, :mollie, :moneris_solutions, :nmi, 
        :oceanpayment, :openpaymx, :optimal_payments, :orangepay, :other, :pacnet_services, :payfast, :paygate, :paymentwall, 
        :payone, :paypal, :payplus, :paystation, :paytrace, :paytrail, :payture, :payu, :payulatam, :payway, :payza, 
        :pinpayments, :princeton_payment_solutions, :psigate, :qiwi, :quickpay, :raberil, :rede, :redpagos, :rewardspay, 
        :sagepay, :securetrading, :simplify_commerce, :skrill, :smartcoin, :solidtrust_pay, :sps_decidir, :stripe, 
        :telerecargas, :towah, :transact_pro, :usa_epay, :vantiv, :verepay, :vericheck, :vindicia, :virtual_card_services, 
        :vme, :vpos, :wirecard, :worldpay
      ]

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
        self.processor  = params[:processor]
      end
    end
  end
end
