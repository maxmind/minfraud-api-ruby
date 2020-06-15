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
    # @!attribute user_id
    # @return [String] MaxMind account ID that is used for authorization
    attr_accessor :user_id

    # @!attribute license_key
    # @return [String] MaxMind license key that is used for authorization
    attr_accessor :license_key

    # @yield [self] to accept configuration settings
    def configure
      yield self
    end

    # @return [Hash] current Minfraud configuration
    def configuration
      {
        user_id:     @user_id,
        license_key: @license_key
      }
    end
  end
end
