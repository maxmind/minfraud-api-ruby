# frozen_string_literal: true

require 'minfraud/model/reason'

module Minfraud
  module Model
    # The risk score multiplier and the reasons for that multiplier.
    class RiskScoreReason < Abstract
      # The factor by which the risk score is increased (if the value is greater than 1)
      # or decreased (if the value is less than 1) for given risk reason(s).
      # Multipliers greater than 1.5 and less than 0.66 are considered significant
      # and lead to risk reason(s) being present.
      #
      # @return [Float]
      attr_reader :multiplier

      # This field contains Risk objects that describe one of the reasons for the multiplier.
      #
      # @return [Array<Minfraud::Model::Risk>]
      attr_reader :reasons

      # @!visibility private
      def initialize(record)
        super

        @multiplier = get('multiplier')

        @reasons = []
        if record&.key?('reasons')
          record['reasons'].each do |r|
            @reasons << Minfraud::Model::Reason.new(r)
          end
        end
      end
    end
  end
end
