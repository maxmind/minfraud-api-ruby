module Minfraud
  class Report
    include ::Minfraud::HTTPService

    # @!attribute transaction
    # @return [Minfraud::Components::Report::Transaction] Report::Transaction component
    attr_accessor :transaction

    # @param  [Hash] params hash of parameters
    # @return [Minfraud::ReportTransaction] ReportTransaction instance
    def initialize(params = {})
      @transaction = params[:transaction]
    end

    # @method report_transaction
    # Makes a request to the minFraud report transactions API.
    # Raises an error in case of invalid response.
    # @return [nil]
    def report_transaction
      raw = request.perform(verb: :post, endpoint: 'transactions/report', body: @transaction.to_json)

      response = ::Minfraud::HTTPService::Response.new(
        status: raw.status.to_i,
        body: raw.body,
        headers: raw.headers
      )
      ::Minfraud::ErrorHandler.examine(response)

      return nil
    end

    # Creates memoized Minfraud::HTTPService::Request instance
    # @return [Minfraud::HTTPService::Request] Request instance based on configuration params
    def request
      @request ||= Request.new(::Minfraud::HTTPService.configuration)
    end
  end
end
