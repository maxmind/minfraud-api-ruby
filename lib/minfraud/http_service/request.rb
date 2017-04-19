require 'faraday'

module Minfraud
  module HTTPService
    class Request
      # @attribute middleware
      # @return [Proc] A proc containing Faraday configuration
      attr_reader :middleware

      # @attribute server
      # @return [String] an API endpoint
      attr_reader :server

      # Creates Minfraud::HTTPService::Request instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::HTTPService::Request] Request instance
      def initialize(params = {})
        @middleware = params[:middleware]
        @server     = params[:server]
      end

      # Performs an HTTP request to the specified endpoint with given body
      # @param  [Hash] params hash of parameters.
      # @return [Farday::Response] Faraday::Response instance
      def perform(params)
        adapter.send *params.values_at(:verb, :endpoint, :body)
      end

      private

      # Creates memoized Faraday::Connection instance
      # @return [Faraday::Connection] Faraday::Connection instance
      def adapter
        @adapter ||= Faraday.new(server, {}, &middleware)
      end
    end
  end
end
