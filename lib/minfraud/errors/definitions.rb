module Minfraud
  module Errors
    module Definitions
      class BaseError          < StandardError; end
      class NotEnumValueError  < BaseError;     end
      class RequestFormatError < BaseError;     end
      class ClientError        < BaseError;     end
      class AuthorizationError < BaseError;     end
      class ServerError        < BaseError;     end
    end
  end
end
