module Minfraud
  module Components
    class CreditCard < Base
      # @attribute issuer_id_number
      # # @return [String] The issuer ID number for the credit card.
      # This is the first 6 digits of the credit card number.
      # It identifies the issuing bank
      attr_accessor :issuer_id_number

      # @attribute last_4_digits
      # @return [String] The last four digits of the credit card number
      attr_accessor :last_4_digits

      # @attribute bank_name
      # @return [String] The name of the issuing bank as provided by the end user
      attr_accessor :bank_name

      # @attribute bank_phone_country_code
      # @return [String] The phone country code for the issuing bank as provided by the end user
      attr_accessor :bank_phone_country_code

      # @attribute bank_phone_number
      # @return [String] The phone number, without the country code, for the issuing bank as provided by the end user
      attr_accessor :bank_phone_number

      # @attribute token
      # @return [String] A token uniquely identifying the card.
      # The token should consist of non-space printable ASCII characters.
      attr_accessor :token

      # @attribute avs_result
      # @return [String] The address verification system (AVS) check result, as returned to you by the credit card processor
      attr_accessor :avs_result

      # @attribute cvv_result
      # @return [String] The card verification value (CVV) code as provided by the payment processor
      attr_accessor :cvv_result
    end
  end
end
