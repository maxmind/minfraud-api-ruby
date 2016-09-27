module Minfraud
  class BaseError          < StandardError; end

  class RequestFormatError < BaseError; end
  class ConfigurationError < BaseError; end
  class ClientError        < BaseError; end
  class AuthorizationError < BaseError; end
  class ServerError        < BaseError; end
end
