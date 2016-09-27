module Minfraud
  class Assessments
    include ::Minfraud::HTTPService
    include ::Minfraud::Resolver

    attr_accessor :account
    attr_accessor :billing
    attr_accessor :credit_card
    attr_accessor :device
    attr_accessor :email
    attr_accessor :event
    attr_accessor :order
    attr_accessor :payment
    attr_accessor :shipping
    attr_accessor :shopping_cart

    def initialize(params = {}, resolver = ::Minfraud::Resolver)
      resolver.assign(context: self, params: params)
    end

    %w(score insights factors).each do |endpoint|
      define_method endpoint do
        raw       = request.perform(verb: :post, endpoint: endpoint, body: request_body)
        response  = ::Minfraud::HTTPService::Response.new(
          status:  raw.status.to_i,
          body:    raw.body,
          headers: raw.headers
        )

        ::Minfraud::ErrorHandler.inspect(response)
      end
    end

    private

    def request_body
      MAPPING.keys.inject({}) { |mem, e| mem.merge!(e.to_s => send(e)&.to_json) }
    end

    # Creates memoized Minfraud::HTTPService::Request instance
    # @return [Minfraud::HTTPService::Request] Request instance based on configuration params
    def request
      @request ||= Request.new(::Minfraud::HTTPService.configuration)
    end
  end
end
