module Minfraud
  module Components
    class Payment < Base
      include ::Minfraud::Enum
      # @attribute processor
      # @return [String] The payment processor used for the transaction
      enum_accessor :processor, {
        :ADYEN                       => 'adyen',
        :ALTAPAY                     => 'altapay',
        :AMAZON_PAYMENTS             => 'amazon_payments',
        :AUTHORIZENET                => 'authorizenet',
        :BALANCED                    => 'balanced',
        :BEANSTREAM                  => 'beanstream',
        :BLUEPAY                     => 'bluepay',
        :BRAINTREE                   => 'braintree',
        :CCNOW                       => 'ccnow',
        :CHASE_PAYMENTECH            => 'chase_paymentech',
        :CIELO                       => 'cielo',
        :COLLECTOR                   => 'collector',
        :COMPROPAGO                  => 'compropago',
        :CONCEPT_PAYMENTS            => 'concept_payments',
        :CONEKTA                     => 'conekta',
        :CUENTADIGITAL               => 'cuentadigital',
        :DALPAY                      => 'dalpay',
        :DIBS                        => 'dibs',
        :DIGITAL_RIVER               => 'digital_river',
        :ECOMM365                    => 'ecomm365',
        :ELAVON                      => 'elavon',
        :EPAY                        => 'epay',
        :EPROCESSING_NETWORK         => 'eprocessing_network',
        :EWAY                        => 'eway',
        :FIRST_DATA                  => 'first_data',
        :GLOBAL_PAYMENTS             => 'global_payments',
        :INGENICO                    => 'ingenico',
        :INTERNETSECURE              => 'internetsecure',
        :INTUIT_QUICKBOOKS_PAYMENTS  => 'intuit_quickbooks_payments',
        :IUGU                        => 'iugu',
        :MASTERCARD_PAYMENT_GATEWAY  => 'mastercard_payment_gateway',
        :MERCADOPAGO                 => 'mercadopago',
        :MERCHANT_ESOLUTIONS         => 'merchant_esolutions',
        :MIRJEH                      => 'mirjeh',
        :MOLLIE                      => 'mollie',
        :MONERIS_SOLUTIONS           => 'moneris_solutions',
        :NMI                         => 'nmi',
        :OPENPAYMX                   => 'openpaymx',
        :OPTIMAL_PAYMENTS            => 'optimal_payments',
        :ORANGEPAY                   => 'orangepay',
        :OTHER                       => 'other',
        :PACNET_SERVICES             => 'pacnet_services',
        :PAYFAST                     => 'payfast',
        :PAYGATE                     => 'paygate',
        :PAYONE                      => 'payone',
        :PAYPAL                      => 'paypal',
        :PAYPLUS                     => 'payplus',
        :PAYSTATION                  => 'paystation',
        :PAYTRACE                    => 'paytrace',
        :PAYTRAIL                    => 'paytrail',
        :PAYTURE                     => 'payture',
        :PAYU                        => 'payu',
        :PAYULATAM                   => 'payulatam',
        :PINPAYMENTS                 => 'pinpayments',
        :PRINCETON_PAYMENT_SOLUTIONS => 'princeton_payment_solutions',
        :PSIGATE                     => 'psigate',
        :QIWI                        => 'qiwi',
        :QUICKPAY                    => 'quickpay',
        :RABERIL                     => 'raberil',
        :REDE                        => 'rede',
        :REDPAGOS                    => 'redpagos',
        :REWARDSPAY                  => 'rewardspay',
        :SAGEPAY                     => 'sagepay',
        :SIMPLIFY_COMMERCE           => 'simplify_commerce',
        :SKRILL                      => 'skrill',
        :SMARTCOIN                   => 'smartcoin',
        :SPS_DECIDIR                 => 'sps_decidir',
        :STRIPE                      => 'stripe',
        :TELERECARGAS                => 'telerecargas',
        :TOWAH                       => 'towah',
        :USA_EPAY                    => 'usa_epay',
        :VEREPAY                     => 'verepay',
        :VINDICIA                    => 'vindicia',
        :VIRTUAL_CARD_SERVICES       => 'virtual_card_services',
        :VME                         => 'vme',
        :WORLDPAY                    => 'worldpay'
      }

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
