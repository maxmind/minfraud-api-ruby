require 'faraday'

module Minfraud
  module HTTPService
    class Request
      attr_reader :middleware
      attr_reader :server

      def initialize(params)
        @middleware = params[:middleware]
        @server     = params[:server]
      end

      def perform(params)
        adapter.send(*params.values_at(:verb, :endpoint, :body))
      end

      private

      def adapter
        @adapter ||= Faraday.new(server, {}, &middleware)
      end
    end
  end
end
