module Minfraud
  class Assessments
    include ::Minfraud::HTTPService
    include ::Minfraud::Resolver

    # @attribute account
    # @return [Minfraud::Components::Account] Account component
    attr_accessor :account

    # @attribute billing
    # @return [Minfraud::Components::Billing] Billing component
    attr_accessor :billing

    # @attribute credit_card
    # @return [Minfraud::Components::CreditCard] CreditCard component
    attr_accessor :credit_card

    # @attribute device
    # @return [Minfraud::Components::Device] Device component
    attr_accessor :device

    # @attribute email
    # @return [Minfraud::Components::Email] Email component
    attr_accessor :email

    # @attribute event
    # @return [Minfraud::Components::Event] Event component
    attr_accessor :event

    # @attribute order
    # @return [Minfraud::Components::Order] Order component
    attr_accessor :order

    # @attribute payment
    # @return [Minfraud::Components::Payment] Payment component
    attr_accessor :payment

    # @!attribute shipping
    # @return [Minfraud::Components::Shipping] Shipping component
    attr_accessor :shipping

    # @!attribute shopping_cart
    # @return [Minfraud::Components::ShoppingCarat] ShoppingCart component
    attr_accessor :shopping_cart

    # @param  [Hash] params hash of parameters
    # @param  [Minfraud::Resolver] resolver resolver that maps params to components
    # @return [Minfraud::Assessments] Assessments instance
    def initialize(params = {}, resolver = ::Minfraud::Resolver)
      resolver.assign(context: self, params: params)
    end

    # These methods correspond to the minFraud API endpoints and require the same set of params
    # Raises an error in case of invalid response
    # @return [Minfraud::HTTPService::Response] Wrapped minFraud response
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
    # Creates a unified request body from components converted to JSON
    # @return [Hash] Request body
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
