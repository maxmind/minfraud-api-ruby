module Minfraud
  module Errors
    module Messages
      AUTHORIZATION_INVALID  = 'Invalid license key and / or user id'.freeze
      INSUFFICIENT_FUNDS     = 'The license key you have provided does not have a sufficient funds to use this service'.freeze
      IP_ADDRESS_INVALID     = 'You have no supplied a valid IPv4 or IPv6 address'.freeze
      IP_ADDRESS_REQUIRED    = 'You have not supplied an IP address which is required filed'.freeze
      IP_ADDRESS_RESERVED    = 'You have supplied an IP address which is reserved'.freeze
      JSON_INVALID           = 'JSON body cannot be decoded'.freeze
      LICENSE_KEY_REQUIRED   = 'You have not supplied a license key'.freeze
      PERMISSION_REQUIRED    = 'You do not have permission to use this service'.freeze
      USER_ID_REQUIRED       = 'You have not supplied a user id'.freeze
      VALUE_IS_NOT_PERMITTED = 'Value is not permitted'.freeze
      SERVER_ERROR           = 'Server error'.freeze
    end
  end
end
