# frozen_string_literal: true

require 'json'

module Minfraud
  # Assessments is used to perform minFraud Score, Insights, and Factors
  # requests.
  #
  # @see https://dev.maxmind.com/minfraud?lang=en
  class Assessments
    include ::Minfraud::Resolver

    # The Account component.
    #
    # @return [Minfraud::Components::Account, nil]
    attr_accessor :account

    # The Billing component.
    #
    # @return [Minfraud::Components::Billing, nil]
    attr_accessor :billing

    # The CreditCard component.
    #
    # @return [Minfraud::Components::CreditCard, nil]
    attr_accessor :credit_card

    # The CustomInputs component.
    #
    # @return [Minfraud::Components::CustomInputs, nil]
    attr_accessor :custom_inputs

    # The Device component.
    #
    # @return [Minfraud::Components::Device, nil]
    attr_accessor :device

    # The Email component.
    #
    # @return [Minfraud::Components::Email, nil]
    attr_accessor :email

    # The Event component.
    #
    # @return [Minfraud::Components::Event, nil]
    attr_accessor :event

    # The Order component.
    #
    # @return [Minfraud::Components::Order, nil]
    attr_accessor :order

    # The Payment component.
    #
    # @return [Minfraud::Components::Payment, nil]
    attr_accessor :payment

    # The Shipping component.
    #
    # @return [Minfraud::Components::Shipping, nil]
    attr_accessor :shipping

    # The ShoppingCart component.
    #
    # @return [Minfraud::Components::ShoppingCart, nil]
    attr_accessor :shopping_cart

    # @param params [Hash] Hash of parameters. Each key is a symbol
    #   corresponding to one of the available component attributes. Values may
    #   be component objects or hashes that will be provided to the component
    #   constructors.
    #
    # @param resolver [Minfraud::Resolver] Resolver that maps parameters to
    #   components.
    def initialize(params = {}, resolver = ::Minfraud::Resolver)
      @locales = params.delete('locales')
      @locales = ['en'] if @locales.nil?

      resolver.assign(self, params)
    end

    # Perform a minFraud Factors request.
    #
    # @return [Minfraud::HTTPService::Response]
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
    def factors
      perform_request(:factors)
    end

    # Perform a minFraud Insights request.
    #
    # @return [Minfraud::HTTPService::Response]
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
    def insights
      perform_request(:insights)
    end

    # Perform a minFraud Score request.
    #
    # @return [Minfraud::HTTPService::Response]
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
    def score
      perform_request(:score)
    end

    private

    def perform_request(endpoint)
      response = nil
      body     = nil
      Minfraud.connection_pool.with do |client|
        response = client.post(
          "/minfraud/v2.0/#{endpoint}",
          body: JSON.generate(request_body),
        )

        body = response.to_s
      end

      response = ::Minfraud::HTTPService::Response.new(
        endpoint,
        @locales,
        response,
        body,
      )

      ::Minfraud::ErrorHandler.examine(response)
    end

    def request_body
      MAPPING.keys.reduce({}) do |mem, e|
        next mem unless (value = send(e))

        mem.merge!(e.to_s => value.to_json)
      end
    end
  end
end
