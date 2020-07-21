# frozen_string_literal: true

module Minfraud
  class Report
    include ::Minfraud::HTTPService

    # The Report::Transaction component.
    #
    # @return [Minfraud::Components::Report::Transaction, nil]
    attr_accessor :transaction

    # @param params [Hash] Hash of parameters.
    def initialize(params = {})
      @transaction = params[:transaction]
    end

    # Perform a request to the minFraud Report Transactions API.
    #
    # @return [nil]
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
      raw = request.perform(
        verb:     :post,
        endpoint: 'transactions/report',
        body:     @transaction.to_json,
      )

      response = ::Minfraud::HTTPService::Response.new(
        status:  raw.status.to_i,
        body:    raw.body,
        headers: raw.headers
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
