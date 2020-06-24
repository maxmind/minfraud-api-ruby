# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Minfraud
  module HTTPService
    class << self
      # @return [Hash] default HTTPService configuration
      def configuration
        server = DEFAULT_SERVER
        if !Minfraud.host.nil?
          server = 'https://' + Minfraud.host + '/minfraud/v2.0'
        end

        {
          middleware: DEFAULT_MIDDLEWARE,
          server:     server,
        }
      end
    end

    # Minfraud default middleware stack
    DEFAULT_MIDDLEWARE = proc do |builder|
      builder.request    :json

      builder.basic_auth(*::Minfraud.configuration.values)

      builder.response   :json, content_type: /\bjson$/

      builder.adapter    Faraday.default_adapter
    end

    # Minfraud default server
    DEFAULT_SERVER = 'https://minfraud.maxmind.com/minfraud/v2.0'
  end
end
