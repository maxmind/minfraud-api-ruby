# frozen_string_literal: true

require 'minfraud'
require 'minfraud/enum'
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
require 'minfraud/http_service'
require 'minfraud/http_service/request'
require 'minfraud/http_service/response'
require 'minfraud/error_handler'
require 'minfraud/assessments'
require 'minfraud/report'

module Minfraud
  class << self
    # The MaxMind account ID that is used for authorization.
    #
    # @return [Integer, nil]
    attr_accessor :account_id

    # The host to use when connecting to the web service.
    #
    # @return [String, nil]
    attr_accessor :host

    # The MaxMind account ID that is used for authorization.
    #
    # @deprecated Use {::account_id} instead. This will be removed in the next
    #   major version.
    #
    # @return [Integer, nil]
    attr_accessor :user_id

    # The MaxMind license key that is used for authorization.
    #
    # @return [String, nil]
    attr_accessor :license_key

    # Yield self to accept configuration settings.
    #
    # @yield [self]
    def configure
      yield self
    end

    # The current Minfraud configuration.
    #
    # @deprecated This will be removed in the next major version.
    #
    # @return [Hash]
    def configuration
      {
        user_id:     @user_id,
        license_key: @license_key
      }
    end
  end
end
