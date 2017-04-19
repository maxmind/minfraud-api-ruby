require 'minfraud/errors/definitions'
require 'minfraud/errors/messages'

module Minfraud
  module Errors
    class Handler
      include Minfraud::Errors::Definitions
      include Minfraud::Errors::Messages

      class << self
        # Returns a response if status code is 200, rises an error otherwise
        # @param [Minfraud::HTTPService::Response] response
        # @return [Minfraud::HTTPService::Response] if status code is 200
        def inspect(response)
          return response if response.ok?

          raise *STATUS_CODES[response.code]
        end
      end

      # Hash that maps status codes returned by minFraud with errors & messages
      STATUS_CODES = Hash.new([ServerError, SERVER_ERROR]).merge(
        AUTHORIZATION_INVALID: [AuthorizationError, AUTHORIZATION_INVALID],
        INSUFFICIENT_FUNDS:    [ClientError, INSUFFICIENT_FUNDS],
        IP_ADDRESS_INVALID:    [ClientError, IP_ADDRESS_INVALID],
        IP_ADDRESS_REQUIRED:   [ClientError, IP_ADDRESS_REQUIRED],
        IP_ADDRESS_RESERVED:   [ClientError, IP_ADDRESS_RESERVED],
        JSON_INVALID:          [ClientError, JSON_INVALID],
        LICENSE_KEY_REQUIRED:  [AuthorizationError, LICENSE_KEY_REQUIRED],
        PERMISSION_REQUIRED:   [ClientError, PERMISSION_REQUIRED],
        USER_ID_REQUIRED:      [AuthorizationError, USER_ID_REQUIRED]
      )
    end
  end
end
