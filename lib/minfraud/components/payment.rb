# frozen_string_literal: true

module Minfraud
  module Components
    class Payment < Base
      include ::Minfraud::Enum
      # @attribute processor
      # @return [String] The payment processor used for the transaction
      enum_accessor :processor, [
        :adyen,
        :affirm,
        :afterpay,
        :altapay,
        :amazon_payments,
        :american_express_payment_gateway,
        :authorizenet,
        :balanced,
        :beanstream,
        :bluepay,
        :bluesnap,
        :bpoint,
        :braintree,
        :cardpay,
        :ccavenue,
        :ccnow,
        :cetelem,
        :chase_paymentech,
        :checkout_com,
        :cielo,
        :collector,
        :commdoo,
        :compropago,
        :concept_payments,
        :conekta,
        :ct_payments,
        :cuentadigital,
        :curopayments,
        :cybersource,
        :dalenys,
        :dalpay,
        :datacash,
        :dibs,
        :digital_river,
        :dotpay,
        :ebs,
        :ecomm365,
        :ecommpay,
        :elavon,
        :emerchantpay,
        :epay,
        :eprocessing_network,
        :epx,
        :eway,
        :exact,
        :first_data,
        :g2a_pay,
        :global_payments,
        :gocardless,
        :heartland,
        :hipay,
        :ingenico,
        :interac,
        :internetsecure,
        :intuit_quickbooks_payments,
        :iugu,
        :klarna,
        :lemon_way,
        :mastercard_payment_gateway,
        :mercadopago,
        :mercanet,
        :merchant_esolutions,
        :mirjeh,
        :mollie,
        :moneris_solutions,
        :nmi,
        :oceanpayment,
        :oney,
        :openpaymx,
        :optimal_payments,
        :orangepay,
        :other,
        :pacnet_services,
        :payeezy,
        :payfast,
        :paygate,
        :paylike,
        :payment_express,
        :paymentwall,
        :payone,
        :paypal,
        :payplus,
        :paysafecard,
        :paystation,
        :paytrace,
        :paytrail,
        :payture,
        :payu,
        :payulatam,
        :payway,
        :payza,
        :pinpayments,
        :posconnect,
        :princeton_payment_solutions,
        :psigate,
        :qiwi,
        :quickpay,
        :raberil,
        :rede,
        :redpagos,
        :rewardspay,
        :sagepay,
        :securetrading,
        :simplify_commerce,
        :skrill,
        :smartcoin,
        :smartdebit,
        :solidtrust_pay,
        :sps_decidir,
        :stripe,
        :synapsefi,
        :telerecargas,
        :towah,
        :transact_pro,
        :usa_epay,
        :vantiv,
        :verepay,
        :vericheck,
        :vindicia,
        :virtual_card_services,
        :vme,
        :vpos,
        :wirecard,
        :worldpay
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
