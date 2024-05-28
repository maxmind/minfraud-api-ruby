# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model containing the IP address's risk for the Score response.
    class ScoreIPAddress < Abstract
      # This field contains the risk associated with the IP address. The value
      # ranges from 0.01 to 99. A higher score indicates a higher risk.
      #
      # @return [Float]
      attr_reader :risk

      # @!visibility private
      def initialize(record)
        super

        @risk = get('risk')
      end
    end
  end
end
