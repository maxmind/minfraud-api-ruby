# frozen_string_literal: true

require 'json'
require 'minfraud/model/error'
require 'minfraud/model/factors'
require 'minfraud/model/insights'
require 'minfraud/model/score'

module Minfraud
  # HTTPService contains classes for handling HTTP communication with the
  # minFraud web services.
  module HTTPService
    # Response class for HTTP requests.
    class Response
      # Response HTTP status code.
      #
      # @return [Integer, nil]
      attr_reader :status

      # Response model.
      #
      # @return [Minfraud::Model::Score, Minfraud::Model::Insights,
      #   Minfraud::Model::Factors, Minfraud::Model::Error, nil]
      attr_reader :body

      # @param endpoint [Symbol, nil] endpoint name, like :score.
      #
      # @param locales [Array<String>, nil] locales, like ["en"].
      #
      # @param response [HTTP::Response] the response object.
      #
      # @param body [String] the response body.
      #
      # @raise [JSON::ParserError] if there was invalid JSON in the response.
      def initialize(endpoint, locales, response, body)
        @status = response.code

        @body = make_body(
          endpoint,
          locales,
          response,
          body,
        )
      end

      # Return the minFraud-specific response code.
      #
      # @return [Symbol, nil]
      def code
        return nil if body.nil?

        body.code.intern if body.respond_to?(:code) && body.code
      end

      private

      def make_body(endpoint, locales, response, body)
        if !response.mime_type || !response.mime_type.match(/json/i)
          return nil
        end

        h = JSON.parse(body)

        if @status != 200
          return Minfraud::Model::Error.new(h)
        end

        ENDPOINT_TO_CLASS[endpoint].new(h, locales)
      end

      ENDPOINT_TO_CLASS = {
        factors:  Minfraud::Model::Factors,
        insights: Minfraud::Model::Insights,
        score:    Minfraud::Model::Score
      }.freeze

      private_constant :ENDPOINT_TO_CLASS
    end
  end
end
