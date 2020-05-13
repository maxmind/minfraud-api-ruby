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

    # @attribute custom_inputs
    # @return [Minfraud::Components::CustomInputs] CustomInputs component
    attr_accessor :custom_inputs

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
    # @note In case when params is a Hash of components it just assigns them to the corresponding instance variables
    # @return [Minfraud::Assessments] Assessments instance
    def initialize(params = {}, resolver = ::Minfraud::Resolver)
      @locales = params.delete('locales')
      @locales = ['en'] if @locales.nil?

      resolver.assign(self, params)
    end

    # @!macro [attach] define
    #   @method $1
    #   Makes a request to minFraud $1 endpoint.
    #   Raises an error in case of invalid response
    #   @return [Minfraud::HTTPService::Response] Wrapped minFraud response
    def self.define(endpoint)
      define_method(endpoint) do
        raw       = request.perform(verb: :post, endpoint: endpoint.to_s, body: request_body)
        response  = ::Minfraud::HTTPService::Response.new(
          endpoint: endpoint,
          locales:  @locales,
          status:   raw.status.to_i,
          body:     raw.body,
          headers:  raw.headers
        )

        ::Minfraud::ErrorHandler.examine(response)
      end
    end

    define :score
    define :insights
    define :factors

    private
    # Creates a unified request body from components converted to JSON
    # @return [Hash] Request body
    def request_body
      MAPPING.keys.inject({}) do |mem, e|
        next mem unless value = send(e)
        mem.merge!(e.to_s => value.to_json)
      end
    end

    # Creates memoized Minfraud::HTTPService::Request instance
    # @return [Minfraud::HTTPService::Request] Request instance based on configuration params
    def request
      @request ||= Request.new(::Minfraud::HTTPService.configuration)
    end
  end
end
