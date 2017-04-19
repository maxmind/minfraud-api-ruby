require 'minfraud/assessments'

module Minfraud
  class << self
    # @!attribute user_id
    # @return [String] MaxMind username that is used for authorization
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
