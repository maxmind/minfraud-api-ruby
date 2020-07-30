# frozen_string_literal: true

module Minfraud
  module Components
    # Account corresponds to the account object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/#Account_(/account)
    class Account < Base
      # A unique user ID associated with the end-user in your system. If your
      # system allows the login name for the account to be changed, this should
      # not be the login name for the account, but rather should be an internal
      # ID that does not change. This is not your MaxMind account ID. No
      # specific format is required.
      #
      # @return [String, nil]
      attr_accessor :user_id

      # An MD5 hash as a hexadecimal string of the username or login name
      # associated with the account.
      #
      # @return [String, nil]
      attr_accessor :username_md5

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @user_id      = params[:user_id]
        @username_md5 = params[:username_md5]
      end
    end
  end
end
