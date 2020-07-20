# frozen_string_literal: true

require 'faraday'

module Minfraud
  module HTTPService
    class Request
      # A proc containing Faraday configuration.
      #
      # @return [Proc, nil]
      attr_reader :middleware

      # The API endpoint.
      #
      # @return [String, nil]
      attr_reader :server

      # @param params [Hash] Hash of parameters.
      def initialize(params = {})
        @middleware = params[:middleware]
        @server     = params[:server]
      end

      # Perform an HTTP request to the specified endpoint with given body.
      #
      # @param params [Hash] Hash of parameters.
      #
      # @return [Farday::Response]
      def perform(params)
        connection = Minfraud.connection
        connection.send(*params.values_at(:verb, :endpoint, :body))
      end
    end
  end
end
