require 'minfraud/model/error'
require 'minfraud/model/factors'
require 'minfraud/model/insights'
require 'minfraud/model/score'

module Minfraud
  module HTTPService
    class Response
      # @attribute status
      # @return [Integer] HTTP response status
      attr_reader :status

      # @attribute body
      # @return [Minfraud::Model::Score, Minfraud::Model::Insights,
      #   Minfraud::Model::Factors] HTTP response body
      attr_reader :body

      # @attribute headers
      # @return [Hash] HTTP response headers
      attr_reader :headers

      # Creates Minfraud::HTTPService::Response instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::HTTPService::Response] Response instance
      def initialize(params = {})
        @status  = params[:status]
        @body    = make_body(
          params[:endpoint],
          params[:body],
          params[:locales]
        )
        @headers = params[:headers]
      end

      # Returns minFraud specific response code
      # @return [Symbol, nil] minFraud specific request code
      def code
        return nil if body.nil?

        body.code.intern if body.respond_to?(:code) && body.code
      end

      private

      def make_body(endpoint, body, locales)
        if @status != 200
          # Won't be a Hash when the body is not JSON.
          return nil unless body.is_a?(Hash)

          return Minfraud::Model::Error.new(body)
        end

        ENDPOINT_TO_CLASS[endpoint].new(body, locales)
      end

      ENDPOINT_TO_CLASS = {
        factors: Minfraud::Model::Factors,
        insights: Minfraud::Model::Insights,
        score: Minfraud::Model::Score
      }.freeze
    end
  end
end
