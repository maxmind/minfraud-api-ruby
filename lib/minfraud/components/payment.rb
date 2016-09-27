module Minfraud
  module Components
    class Payment < Base
      attr_accessor :processor
      attr_accessor :was_authorized
      attr_accessor :decline_code

      def initialize(params = {})
        @was_authorized = params[:was_authorized]
        @decline_code   = params[:decline_code]
        @processor      = params[:processor]
      end
    end
  end
end
