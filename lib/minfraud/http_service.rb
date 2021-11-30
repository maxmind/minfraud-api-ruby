# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module Minfraud
  # HTTPService holds the HTTP client configuration.
  module HTTPService
    class << self
      # The default HTTPService configuration.
      #
      # @return [Hash]
      def configuration
        server = DEFAULT_SERVER
        if !Minfraud.host.nil?
          server = "https://#{Minfraud.host}/minfraud/v2.0"
        end

        {
          middleware: DEFAULT_MIDDLEWARE,
          server:     server,
        }
      end
    end

    # @!visibility private
    DEFAULT_MIDDLEWARE = proc do |builder|
      builder.request    :json

      account_id = Minfraud.account_id
      account_id = Minfraud.user_id if account_id.nil?

      if Faraday::VERSION.to_i.zero?
        builder.basic_auth account_id, Minfraud.license_key
      else
        builder.request :basic_auth, account_id, Minfraud.license_key
      end

      builder.response :json, content_type: /\bjson$/

      builder.adapter :net_http_persistent, pool_size: 5 do |http|
        http.idle_timeout = 30
      end
    end

    # Default base URL for minFraud.
    DEFAULT_SERVER = 'https://minfraud.maxmind.com/minfraud/v2.0'
  end
end
