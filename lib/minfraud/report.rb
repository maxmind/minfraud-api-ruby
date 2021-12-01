# frozen_string_literal: true

require 'json'

module Minfraud
  # Report is used to perform minFraud Report Transaction API requests.
  #
  # @see https://dev.maxmind.com/minfraud/report-a-transaction?lang=en
  class Report
    # The Report::Transaction component.
    #
    # @return [Minfraud::Components::Report::Transaction, nil]
    attr_accessor :transaction

    # @param params [Hash] Hash of parameters. The only supported key is
    #   +:transaction+, which should have a
    #   +Minfraud::Components::Report::Transaction+ as its value.
    def initialize(params = {})
      @transaction = params[:transaction]
    end

    # Perform a request to the minFraud Report Transaction API.
    #
    # @return [nil]
    #
    # @raise [JSON::ParserError] if there was invalid JSON in the response.
    #
    # @raise [Minfraud::AuthorizationError] If there was an authentication
    #   problem.
    #
    # @raise [Minfraud::ClientError] If there was a critical problem with one
    #   of your inputs.
    #
    # @raise [Minfraud::ServerError] If the server reported an error of some
    #   kind.
    def report_transaction
      response = nil
      body     = nil
      Minfraud.connection_pool.with do |client|
        response = client.post(
          '/minfraud/v2.0/transactions/report',
          body: JSON.generate(@transaction.to_json),
        )

        body = response.to_s
      end

      endpoint = nil
      locales  = nil
      response = ::Minfraud::HTTPService::Response.new(
        endpoint,
        locales,
        response,
        body,
      )

      ::Minfraud::ErrorHandler.examine(response)

      nil
    end

    private

    def request
      @request ||= Request.new(::Minfraud::HTTPService.configuration)
    end
  end
end
