# frozen_string_literal: true

require 'minfraud/model/insights'
require 'minfraud/model/subscores'
require 'minfraud/model/risk_score_reason'

module Minfraud
  module Model
    # Model representing the Factors response.
    class Factors < Insights
      # This field contains RiskScoreReason objects that describe risk score reasons
      # for a given transaction that change the risk score significantly.
      # Risk score reasons are usually only returned for medium to high risk transactions.
      # If there were no significant changes to the risk score due to these reasons,
      # then this array will be empty.
      #
      # @return [Array<Minfraud::Model::RiskScoreReason>]
      attr_reader :risk_score_reasons

      # An object containing scores for many of the individual risk factors
      # that are used to calculate the overall risk score.
      #
      # @return [Minfraud::Model::Subscores]
      # @deprecated Use {#risk_score_reasons} instead.
      attr_reader :subscores

      # @!visibility private
      def initialize(record, locales)
        super

        @risk_score_reasons = []
        if record&.key?('risk_score_reasons')
          record['risk_score_reasons'].each do |r|
            @risk_score_reasons << Minfraud::Model::RiskScoreReason.new(r)
          end
        end

        @subscores = Minfraud::Model::Subscores.new(get('subscores'))
      end
    end
  end
end
