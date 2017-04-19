require 'faraday'
require 'faraday_middleware'

module Minfraud
  module HTTPService
    class << self
      # @return [Hash] default HTTPService configuration
      def configuration
        {
          middleware: DEFAULT_MIDDLEWARE,
          server:     DEFAULT_SERVER
        }
      end
    end

    # Minfraud default middleware stack
    DEFAULT_MIDDLEWARE = proc do |builder|
      builder.request    :json

      builder.basic_auth *::Minfraud.configuration.values

      builder.response   :mashify
      builder.response   :json, content_type: /\bjson$/

      builder.adapter    Faraday.default_adapter
    end

    # Minfraud default server
    DEFAULT_SERVER = 'https://minfraud.maxmind.com/minfraud/v2.0'.freeze
  end
end
