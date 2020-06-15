module Minfraud
  module Components
    class Account < Base
      # @attribute user_id
      # @return [String] A unique user ID associated with the end-user in your system.
      # If your system allows the login name for the account to be changed, this should not be the login name for the account,
      # but rather should be an internal ID that does not change. This is not your MaxMind user ID.
      attr_accessor :user_id

      # @attribute username_md5
      # @return [String] An MD5 hash as a hexadecimal string of the username or login name associated with the account
      attr_accessor :username_md5

      # Creates Minfraud::Components::Account instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Account] an Account instance
      def initialize(params = {})
        @user_id      = params[:user_id]
        @username_md5 = params[:username_md5]
      end
    end
  end
end
