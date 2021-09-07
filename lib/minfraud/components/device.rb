# frozen_string_literal: true

module Minfraud
  module Components
    # Device corresponds to the device object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--device
    class Device < Base
      include Minfraud::Validates

      # The IP address associated with the device used by the customer in the
      # transaction. The IP address must be in IPv4 or IPv6 presentation
      # format, i.e., dotted-quad notation or the IPv6 hexadecimal-colon
      # notation.
      #
      # @return [String, nil]
      attr_accessor :ip_address

      # The HTTP "User-Agent" header of the browser used in the transaction.
      #
      # @return [String, nil]
      attr_accessor :user_agent

      # The HTTP "Accept-Language" header of the browser used in the
      # transaction.
      #
      # @return [String, nil]
      attr_accessor :accept_language

      # The number of seconds between the creation of the user's session and
      # the time of the transaction. Note that session_age is not the duration
      # of the current visit, but the time since the start of the first visit.
      # The value must be at least 0 and at most 10^13-1.
      #
      # @return [Float, nil]
      attr_accessor :session_age

      # An ID that uniquely identifies a visitor's session on the site.
      #
      # @return [String, nil]
      attr_accessor :session_id

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @ip_address      = params[:ip_address]
        @user_agent      = params[:user_agent]
        @accept_language = params[:accept_language]
        @session_age     = params[:session_age]
        @session_id      = params[:session_id]

        validate
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_ip('ip_address', @ip_address)
        validate_string('user_agent', 512, @user_agent)
        validate_string('accept_language', 255, @accept_language)
        validate_nonnegative_number('session_age', @session_age)
        validate_string('session_id', 255, @session_id)
      end
    end
  end
end
