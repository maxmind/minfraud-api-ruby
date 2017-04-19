module Minfraud
  module Components
    class Payment < Base
      extend ::Minfraud::Enum
      # @attribute processor
      # @return [String] The payment processor used for the transaction
      enum_accessor :processor, %i[
        adyen
        altapay
        amazon_payments
        authorizenet
        balanced
        beanstream
        bluepay
        braintree
        ccnow
        chase_paymentech
        cielo
        collector
        compropago
        concept_payments
        conekta
        cuentadigital
        dalpay
        dibs
        digital_river
        ecomm365
        elavon
        epay
        eprocessing_network
        eway
        first_data
        global_payments
        ingenico
        internetsecure
        intuit_quickbooks_payments
        iugu
        mastercard_payment_gateway
        merchant_esolutions
        mirjeh
        mollie
        moneris_solutions
        nmi
        openpaymx
        optimal_payments
        orangepay
        other
        pacnet_services
        payfast
        paygate
        payone
        paypal
        payplus
        paystation
        paytrace
        paytrail
        payture
        payu
        payulatam
        pinpayments
        princeton_payment_solutions
        psigate
        qiwi
        quickpay
        raberil
        rede
        redpagos
        rewardspay
        sagepay
        simplify_commerce
        skrill
        smartcoin
        sps_decidir
        stripe
        telerecargas
        towah
        usa_epay
        verepay
        vindicia
        virtual_card_services
        vme
        worldpay
      ]

      # @attribute was_authorized
      # @return [Boolean] The authorization outcome from the payment processor.
      # If the transaction has not yet been approved or denied, do not include this field
      attr_accessor :was_authorized

      # @attribute decline_code
      # @return [String] The decline code as provided by your payment processor.
      # If the transaction was not declined, do not include this field
      attr_accessor :decline_code
    end
  end
end
