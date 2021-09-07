# frozen_string_literal: true

module Minfraud
  module Components
    module Report
      # Contains the fields used in the Report Transaction API.
      #
      # @see https://dev.maxmind.com/minfraud/report-a-transaction?lang=en
      class Transaction < Base
        include ::Minfraud::Enum

        # The IP address of the customer placing the order. This should be
        # passed as a string like "152.216.7.110".
        #
        # @return [String, nil]
        attr_accessor :ip_address

        # A symbol indicating the likelihood that a transaction may be
        # fraudulent.
        #
        # This may be one of +:chargeback+, +:not_fraud+, +:spam_or_abuse+, or
        # +:suspected_fraud+.
        #
        # @!attribute tag
        #
        # @return [Symbol, nil]
        enum_accessor :tag, [:chargeback, :not_fraud, :spam_or_abuse, :suspected_fraud]

        # A string which is provided by your payment processor indicating the
        # reason for the chargeback.
        #
        # @return [String, nil]
        attr_accessor :chargeback_code

        # A unique eight character string identifying a minFraud Standard or
        # Premium request. These IDs are returned in the maxmindID field of a
        # response for a successful minFraud request. This field is not
        # required, but you are encouraged to provide it, if possible.
        #
        # @return [String, nil]
        attr_accessor :maxmind_id

        # A UUID that identifies a minFraud Score, minFraud Insights, or
        # minFraud Factors request. This ID is returned at /id in the response.
        # This field is not required, but you are encouraged to provide it if
        # the request was made to one of these services.
        #
        # @return [String, nil]
        attr_accessor :minfraud_id

        # Your notes on the fraud tag associated with the transaction. We
        # manually review many reported transactions to improve our scoring for
        # you so any additional details to help us understand context are
        # helpful.
        #
        # @return [String, nil]
        attr_accessor :notes

        # The transaction ID you originally passed to minFraud. This field is
        # not required, but you are encouraged to provide it or the
        # transaction's maxmind_id or minfraud_id.
        #
        # @return [String, nil]
        attr_accessor :transaction_id

        # @param params [Hash] Hash of parameters. Each key/value should
        #   correspond to one of the available attributes.
        def initialize(params = {})
          @ip_address      = params[:ip_address]
          @chargeback_code = params[:chargeback_code]
          @maxmind_id      = params[:maxmind_id]
          @minfraud_id     = params[:minfraud_id]
          @notes           = params[:notes]
          @transaction_id  = params[:transaction_id]
          self.tag         = params[:tag]
        end
      end
    end
  end
end
