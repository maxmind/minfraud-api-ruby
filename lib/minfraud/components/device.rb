module Minfraud
  module Components
    class Device < Base
      # @!attribute ip_address
      # @return [String] The IP address associated with the device used by the customer in the transaction.
      # The IP address must be in IPv4 or IPv6 presentation format
      attr_accessor :ip_address

      # @attribute user_agent
      # @return [String] The HTTP "User-Agent" header of the browser used in the transaction
      attr_accessor :user_agent

      # @attribute :accept_language
      # @return [String] The HTTP "Accept-Language" header of the browser used in the transaction
      attr_accessor :accept_language

      # Creates Minfraud::Components::Device instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Device] a Device instance
      def initialize(params = {})
        @ip_address      = params[:ip_address]
        @user_agent      = params[:user_agent]
        @accept_language = params[:accept_language]
      end
    end
  end
end
