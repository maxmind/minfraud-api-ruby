# frozen_string_literal: true

module Minfraud
  module Components
    class Email < Base
      # This field must be either a valid email address or an MD5 of the email
      # used in the transaction.
      #
      # @return [String, nil]
      attr_accessor :address

      # The domain of the email address used in the transaction.
      #
      # @return [String, nil]
      attr_accessor :domain

      # @param params [Hash] Hash of parameters.
      def initialize(params = {})
        @address = params[:address]
        @domain  = params[:domain]
      end
    end
  end
end
