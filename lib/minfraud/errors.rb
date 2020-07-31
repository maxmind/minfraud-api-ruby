# frozen_string_literal: true

module Minfraud
  # The base error class for Minfraud exceptions.
  class BaseError          < StandardError; end

  # An error indicating the value is not valid for the enumerated type.
  class NotEnumValueError  < BaseError; end

  # An error indicating the field is not recognized.
  class RequestFormatError < BaseError; end

  # An error indicating minFraud cannot serve your request as there is a
  # problem on the client side.
  #
  # For example, this may happen if there is a problem with the format or
  # contents of your request, if you lack funds to use the service, or if you
  # don't have permission to use the service.
  class ClientError        < BaseError; end

  # An error indicating there is a problem with authorization or
  # authentication.
  class AuthorizationError < BaseError; end

  # An error indicating the server had an error handling the request.
  class ServerError        < BaseError; end
end
