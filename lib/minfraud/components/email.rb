# frozen_string_literal: true

module Minfraud
  module Components
    # Email corresponds to the email object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Email_(/email)
    class Email < Base
      # This field must be either be a valid email address or an MD5 of the
      # lowercased email used in the transaction. Important: if using the MD5
      # hash, please be sure to convert the email address to lowercase before
      # calculating its MD5 hash.
      #
      # @return [String, nil]
      attr_accessor :address

      # The domain of the email address used in the transaction.
      #
      # @return [String, nil]
      attr_accessor :domain

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @address = params[:address]
        @domain  = params[:domain]
      end
    end
  end
end
