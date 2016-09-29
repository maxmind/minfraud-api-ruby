module Minfraud
  # A list of Minfraud custom errors
  class BaseError          < StandardError; end

  class RequestFormatError < BaseError; end
  class ClientError        < BaseError; end
  class AuthorizationError < BaseError; end
  class ServerError        < BaseError; end
end
