# frozen_string_literal: true

module Minfraud
  module ErrorHandler
    class << self
      # Returns a response if status code is 2xx, raises an error otherwise
      # @param [Minfraud::HTTPService::Response] response
      # @return [Minfraud::HTTPService::Response] if status code is 200
      def examine(response)
        return response if response.status > 199 && response.status < 300

        raise(*STATUS_CODES.fetch(response.code, [ServerError, 'Server error']))
      end

      # A hash that maps status codes returned by minFraud with errors & messages
      STATUS_CODES = {
        IP_ADDRESS_INVALID:    [
          ClientError, 'You have not supplied a valid IPv4 or IPv6 address'
        ],
        IP_ADDRESS_REQUIRED:   [
          ClientError, 'You have not supplied an IP address which is a required field'
        ],
        IP_ADDRESS_RESERVED:   [
          ClientError, 'You have supplied an IP address which is reserved'
        ],
        JSON_INVALID:          [
          ClientError, 'JSON body cannot be decoded'
        ],
        MAXMIND_ID_INVALID:    [
          ClientError, 'You have not supplied a valid maxmind_id'
        ],
        MINFRAUD_ID_INVALID:   [
          ClientError, 'You have not supplied a valid minfraud_id'
        ],
        PARAMETER_UNKNOWN:     [
          ClientError, 'You have supplied an unknown parameter'
        ],
        TAG_REQUIRED:          [
          ClientError, 'You have not supplied a tag, which is a required field'
        ],
        TAG_INVALID:           [
          ClientError, 'You have not supplied a valid tag'
        ],
        ACCOUNT_ID_REQUIRED:   [
          AuthorizationError, 'You have not supplied a account ID'
        ],
        AUTHORIZATION_INVALID: [
          AuthorizationError, 'Invalid license key and / or account ID'
        ],
        LICENSE_KEY_REQUIRED:  [
          AuthorizationError, 'You have not supplied a license key'
        ],
        USER_ID_REQUIRED:      [
          AuthorizationError, 'You have not supplied a account id'
        ],
        INSUFFICIENT_FUNDS:    [
          ClientError, 'The license key you have provided does not have a sufficient funds to use this service'
        ],
        PERMISSION_REQUIRED:   [
          ClientError, 'You do not have permission to use this service'
        ]
      }.freeze
    end
  end
end
