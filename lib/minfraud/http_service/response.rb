module Minfraud
  module HTTPService
    class Response
      # @attribute status
      # @return [Integer] HTTP response status
      attr_reader :status

      # @attribute body
      # @return [Hash] HTTP response body
      attr_reader :body

      # @attribute headers
      # @return [Hash] HTTP response headers
      attr_reader :headers

      # Creates Minfraud::HTTPService::Response instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::HTTPService::Response] Response instance
      def initialize(params = {})
        @status  = params[:status]
        @body    = params[:body]
        @headers = params[:headers]
      end

      def ok?
        status.to_i == 200
      end

      # Returns minFraud specific response code
      # @return [Symbol] minFraud specific request code
      def code
        body.code.intern if body.respond_to?(:code) && body.code
      end
    end
  end
end
