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

      # @attribute :session_age
      # @return [Decimal] The number of seconds between the creation of the user’s session and the time of the transaction.
      # Note that session_age is not the duration of the current visit, but the time since the start of the first visit.
      attr_accessor :session_age

      # @attribute :session_id
      # @return [String] An ID that uniquely identifies a visitor’s session on the site.
      attr_accessor :session_id
    end
  end
end
