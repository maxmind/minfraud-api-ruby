module Minfraud
  module ErrorHandler
    class << self
      # Returns a response if status code is 200, rises an error otherwise
      # @param [Minfraud::HTTPService::Response] response
      # @return [Minfraud::HTTPService::Response] if status code is 200
      def inspect(response)
        return response if response.status == 200

        raise *STATUS_CODES.fetch(response.code, [ServerError, 'Server error'])
      end

      # A hash that maps status codes returned by minFraud with errors & messages
      STATUS_CODES = {
        IP_ADDRESS_INVALID:    [
          ClientError, 'You have no supplied a valid IPv4 or IPv6 address'
        ],
        IP_ADDRESS_REQUIRED:   [
          ClientError,  'You have not supplied an IP address which is required filed'
        ],
        IP_ADDRESS_RESERVED:   [
          ClientError, 'You have supplied an IP address which is reserved'
        ],
        JSON_INVALID:          [
          ClientError, 'JSON body cannot be decoded'
        ],
        ACCOUNT_ID_REQUIRED:      [
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
      }
    end
  end
end
