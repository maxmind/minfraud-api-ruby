# frozen_string_literal: true

module Minfraud
  module Components
    # CreditCard corresponds to the credit_card object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--credit-card
    class CreditCard < Base
      include Minfraud::Validates

      # The issuer ID number for the credit card. This is the first 6 or 8
      # digits of the credit card number. It identifies the issuing bank.
      #
      # @return [String, nil]
      attr_accessor :issuer_id_number

      # The last two or four digits of the credit card number. In most cases,
      # you should send the last four digits for +last_digits+.
      #
      # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--credit-card__last_digits
      #
      # @return [String, nil]
      attr_accessor :last_digits

      # The name of the issuing bank as provided by the end user.
      #
      # @return [String, nil]
      attr_accessor :bank_name

      # The phone country code for the issuing bank as provided by the end
      # user. If you provide this information then you must provide at least
      # one digit.
      #
      # @return [String, nil]
      attr_accessor :bank_phone_country_code

      # The phone number, without the country code, for the issuing bank as
      # provided by the end user. Punctuation characters will be stripped.
      # After stripping punctuation characters, the number must contain only
      # digits.
      #
      # @return [String, nil]
      attr_accessor :bank_phone_number

      # The two character ISO 3166-1 alpha-2 country code where the issuer of
      # the card is located. This may be passed instead of {#issuer_id_number}
      # if you do not wish to pass partial account numbers, or if your payment
      # processor does not provide them.
      #
      # @see https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
      #
      # @return [String, nil]
      attr_accessor :country

      # A token uniquely identifying the card. The token should consist of
      # non-space printable ASCII characters. If the token is all digits, it
      # must be more than 19 characters long. The token must not be a primary
      # account number (PAN) or a simple transformation of it. If you have a
      # valid token that looks like a PAN but is not one, you may prefix that
      # token with a fixed string, e.g., +token-+.
      #
      # @return [String, nil]
      attr_accessor :token

      # The address verification system (AVS) check result, as returned to you
      # by the credit card processor. The minFraud service supports the
      # standard AVS codes.
      #
      # @return [String, nil]
      attr_accessor :avs_result

      # The card verification value (CVV) code as provided by the payment
      # processor.
      #
      # @return [String, nil]
      attr_accessor :cvv_result

      # Whether the outcome of 3-D Secure verification (e.g. SafeKey,
      # SecureCode, Verified by Visa) was successful. +true+ if customer
      # verification was successful, or +false+ if the customer failed
      # verification. If 3-D Secure verification was not used, was unavailable,
      # or resulted in an outcome other than success or failure, do not
      # include this field.
      #
      # @return [Boolean, nil]
      attr_accessor :was_3d_secure_successful

      # Get the last digits of the credit card number.
      #
      # @deprecated Use {#last_digits} instead.
      #
      # @return [String, nil]
      def last_4_digits
        @last_digits
      end

      # Set the last digits of the credit card number.
      #
      # @deprecated Use {#last_digits} instead.
      #
      # @return [String, nil]
      def last_4_digits=(last4)
        @last_digits = last4
      end

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @bank_phone_country_code  = params[:bank_phone_country_code]
        @country                  = params[:country]
        @issuer_id_number         = params[:issuer_id_number]
        @last_digits              = params[:last_digits] || params[:last_4_digits]
        @bank_name                = params[:bank_name]
        @bank_phone_number        = params[:bank_phone_number]
        @avs_result               = params[:avs_result]
        @cvv_result               = params[:cvv_result]
        @token                    = params[:token]
        @was_3d_secure_successful = params[:was_3d_secure_successful]

        validate
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_telephone_country_code('bank_phone_country_code', @bank_phone_country_code)
        validate_country_code('country', @country)
        validate_regex('issuer_id_number', /\A(?:[0-9]{6}|[0-9]{8})\z/, @issuer_id_number)
        validate_regex('last_digits', /\A(?:[0-9]{2}|[0-9]{4})\z/, @last_digits)
        validate_string('bank_name', 255, @bank_name)
        validate_string('bank_phone_number', 255, @bank_phone_number)
        validate_string('avs_result', 1, @avs_result)
        validate_string('cvv_result', 1, @cvv_result)
        validate_credit_card_token('token', @token)
        validate_boolean('was_3d_secure_successful', @was_3d_secure_successful)
      end
    end
  end
end
