# frozen_string_literal: true

require 'connection_pool'
require 'http'
require 'minfraud'
require 'minfraud/enum'
require 'minfraud/validates'
require 'minfraud/components/base'
require 'minfraud/components/account'
require 'minfraud/components/addressable'
require 'minfraud/components/billing'
require 'minfraud/components/credit_card'
require 'minfraud/components/custom_inputs'
require 'minfraud/components/device'
require 'minfraud/components/email'
require 'minfraud/components/event'
require 'minfraud/components/order'
require 'minfraud/components/payment'
require 'minfraud/components/report/transaction'
require 'minfraud/components/shipping'
require 'minfraud/components/shopping_cart'
require 'minfraud/components/shopping_cart_item'
require 'minfraud/resolver'
require 'minfraud/version'
require 'minfraud/errors'
require 'minfraud/http_service/response'
require 'minfraud/error_handler'
require 'minfraud/assessments'
require 'minfraud/report'

# This class holds global configuration parameters and provides a namespace
# for the gem's classes.
module Minfraud
  class << self
    # rubocop:disable ThreadSafety/ClassAndModuleAttributes
    # This is a false positive - these configuration attributes are set during initialization

    # The MaxMind account ID that is used for authorization.
    #
    # @return [Integer, nil]
    attr_accessor :account_id

    # Enable client side validation. This is disabled by default.
    #
    # @return [Boolean, nil]
    attr_accessor :enable_validation

    # The host to use when connecting to the web service.
    # By default, the client connects to the production host. However,
    # during testing and development, you can set this option to
    # 'sandbox.maxmind.com' to use the Sandbox environment's host. The
    # sandbox allows you to experiment with the API without affecting your
    # production data.
    #
    # @return [String, nil]
    attr_accessor :host

    # The MaxMind license key that is used for authorization.
    #
    # @return [String, nil]
    attr_accessor :license_key

    # rubocop:enable ThreadSafety/ClassAndModuleAttributes

    # @!visibility private
    attr_reader :connection_pool

    # Yield self to accept configuration settings.
    #
    # @yield [self]
    def configure
      yield self

      pool_size        = 5
      # rubocop:disable ThreadSafety/ClassInstanceVariable
      # This is a false positive - this configuration is set during initialization
      host             = @host.nil? ? 'minfraud.maxmind.com' : @host
      @connection_pool = ConnectionPool.new(size: pool_size) do
        # rubocop:enable ThreadSafety/ClassInstanceVariable
        make_http_client.persistent("https://#{host}")
      end
    end

    private

    def make_http_client
      # rubocop:disable ThreadSafety/ClassInstanceVariable
      # This is a false positive - this configuration is set during initialization
      HTTP.basic_auth(
        user: @account_id,
        pass: @license_key,
      ).headers(
        # rubocop:enable ThreadSafety/ClassInstanceVariable
        accept:     'application/json',
        user_agent: "minfraud-api-ruby/#{Minfraud::VERSION} ruby/#{RUBY_VERSION} http/#{HTTP::VERSION}",
      )
    end
  end
end
