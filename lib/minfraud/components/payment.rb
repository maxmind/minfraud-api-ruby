# frozen_string_literal: true

module Minfraud
  module Components
    # Payment corresponds to the payment object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Payment_(/payment)
    class Payment < Base
      include ::Minfraud::Enum
      include Minfraud::Validates

      # The payment processor used for the transaction. The value is one
      # listed as a valid value, as a symbol.
      #
      # @!attribute processor
      #
      # @return [Symbol, nil]
      enum_accessor :processor, [
        :adyen,
        :affirm,
        :afterpay,
        :altapay,
        :amazon_payments,
        :american_express_payment_gateway,
        :apple_pay,
        :aps_payments,
        :authorizenet,
        :balanced,
        :beanstream,
        :bluepay,
        :bluesnap,
        :bpoint,
        :braintree,
        :cardknox,
        :cardpay,
        :cashfree,
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
        :creditguard,
        :credorax,
        :ct_payments,
        :cuentadigital,
        :curopayments,
        :cybersource,
        :dalenys,
        :dalpay,
        :datacap,
        :datacash,
        :dibs,
        :digital_river,
        :dlocal,
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
        :first_atlantic_commerce,
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
        :komoju,
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
        :onpay,
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
        :paytm,
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
        :razorpay,
        :rede,
        :redpagos,
        :rewardspay,
        :safecharge,
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
        :systempay,
        :telerecargas,
        :towah,
        :transact_pro,
        :tsys,
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

      # The authorization outcome from the payment processor. If the
      # transaction has not yet been approved or denied, do not include this
      # field.
      #
      # @return [Boolean, nil]
      attr_accessor :was_authorized

      # The decline code as provided by your payment processor. If the
      # transaction was not declined, do not include this field.
      #
      # @return [String, nil]
      attr_accessor :decline_code

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @was_authorized = params[:was_authorized]
        @decline_code   = params[:decline_code]
        self.processor  = params[:processor]

        validate
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_boolean('was_authorized', @was_authorized)
        validate_string('decline_code', 255, @decline_code)
      end
    end
  end
end
