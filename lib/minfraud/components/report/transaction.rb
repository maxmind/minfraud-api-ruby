# frozen_string_literal: true

module Minfraud
  module Components
    module Report
      # Contains the fields used in the Report Transaction API.
      #
      # @see https://dev.maxmind.com/minfraud/report-a-transaction?lang=en
      class Transaction < Base
        include ::Minfraud::Enum
        include ::Minfraud::Validates

        # The IP address of the customer placing the order. This should be
        # passed as a string like "152.216.7.110". This field is not required
        # if you provide at least one of the transaction's minfraud_id,
        # maxmind_id, or transaction_id. You are encouraged to provide it, if
        # possible.
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
        enum_accessor :tag, %i[chargeback not_fraud spam_or_abuse suspected_fraud]

        # A string which is provided by your payment processor indicating the
        # reason for the chargeback.
        #
        # @return [String, nil]
        attr_accessor :chargeback_code

        # A unique eight character string identifying a minFraud Standard or
        # Premium request. These IDs are returned in the maxmindID field of a
        # response for a successful minFraud request. This field is not required
        # if you provide at least one of the transaction's ip_address,
        # minfraud_id, or transaction_id. You are encouraged to provide it, if
        # possible.
        #
        # @return [String, nil]
        attr_accessor :maxmind_id

        # A UUID that identifies a minFraud Score, minFraud Insights, or
        # minFraud Factors request. This ID is returned at /id in the response.
        # This field is not required if you provide at least one of the
        # transaction's ip_address, maxmind_id, or transaction_id. You are
        # encouraged to provide it, if possible.
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

        # The transaction ID you originally passed to minFraud. This field
        # is not required if you provide at least one of the transaction's
        # ip_address, maxmind_id, or minfraud_id. You are encouraged to
        # provide it, if possible.
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

          validate
        end

        private

        def validate
          return if !Minfraud.enable_validation

          validate_ip('ip_address', @ip_address)
          validate_string('maxmind_id', 8, @maxmind_id)
          validate_uuid('minfraud_id', @minfraud_id)

          if ip_address.nil? &&
             (minfraud_id.nil? || empty_uuid?(minfraud_id)) &&
             (maxmind_id.nil? || maxmind_id.empty?) &&
             (transaction_id.nil? || transaction_id.empty?)
            raise ArgumentError, 'At least one of the following is required: ip_address, minfraud_id, maxmind_id, transaction_id.'
          end
        end

        def empty_uuid?(value)
          stripped_value = value.to_s.delete('-')
          stripped_value == '0' * 32
        end
      end
    end
  end
end
