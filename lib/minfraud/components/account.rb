module Minfraud
  module Components
    class Account < Base
      # @attribute user_id
      # @return [String] A unique user ID associated with the end-user that does not change.
      # This is not MaxMind user ID
      attr_accessor :user_id

      # @attribute username_md5
      # @return [String] An MD5 hash as a hexadecimal string of the username or login name associated with the account
      attr_accessor :username_md5
    end
  end
end
