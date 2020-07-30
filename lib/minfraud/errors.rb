# frozen_string_literal: true

module Minfraud
  # The base error class for Minfraud exceptions.
  class BaseError          < StandardError; end

  # An error indicating the value is not valid for the enumerated type.
  class NotEnumValueError  < BaseError; end

  # An error indicating the field is not recognized.
  class RequestFormatError < BaseError; end

  # An error indicating there is a critical problem with the request.
  class ClientError        < BaseError; end

  # An error indicating there is a problem with authorization or
  # authentication.
  class AuthorizationError < BaseError; end

  # An error indicating the server had an error handling the request.
  class ServerError        < BaseError; end
end
