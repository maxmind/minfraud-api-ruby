module Minfraud
  module Components
    class Email < Base
      # @attribute address
      # @return [String] This field must be either a valid email address or an MD5 of the email used in the transaction
      attr_accessor :address

      # @attribute domain
      # @return [String] The domain of the email address used in the transaction
      attr_accessor :domain

      # Creates Minfraud::Components::Email instance
      # @param  [Hash] params hash of parameters
      # @return [Minfraud::Components::Email] an Email instance
      def initialize(params = {})
        @address = params[:address]
        @domain  = params[:domain]
      end
    end
  end
end
