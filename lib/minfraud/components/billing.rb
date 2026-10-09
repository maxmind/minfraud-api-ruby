# frozen_string_literal: true

module Minfraud
  module Components
    # Billing corresponds to the billing object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests/?lang=en#schema--request--billing
    class Billing < Addressable
      include ::Minfraud::Enum

      # The most recent method used to verify the billing phone number. This
      # must be one of +:delivered_code+, +:network+, or +:other+.
      # +:delivered_code+ is a code delivered to the phone, such as by SMS,
      # voice call, or messaging app. +:network+ is verification through the
      # mobile network operator, such as silent network authentication.
      #
      # @!attribute phone_verification_method
      #
      # @return [Symbol, nil]
      enum_accessor :phone_verification_method, %i[delivered_code network other]

      # Whether the most recent verification of the billing phone number
      # succeeded. Do not include this field if no verification was
      # attempted.
      #
      # @return [Boolean, nil]
      attr_accessor :phone_was_verification_successful

      # The date and time of the most recent verification of the billing phone
      # number. The string must be in the RFC 3339 date-time format, e.g.,
      # "2012-04-12T23:20:50.52Z".
      #
      # @see https://datatracker.ietf.org/doc/html/rfc3339
      #
      # @return [String, nil]
      attr_accessor :phone_verification_time

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        self.phone_verification_method     = params[:phone_verification_method]
        @phone_was_verification_successful = params[:phone_was_verification_successful]
        @phone_verification_time           = params[:phone_verification_time]
        super
      end

      private

      def validate
        super
        return if !Minfraud.enable_validation

        validate_boolean('phone_was_verification_successful', @phone_was_verification_successful)
        validate_rfc3339('phone_verification_time', @phone_verification_time)
      end
    end
  end
end
