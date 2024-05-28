# frozen_string_literal: true

require 'minfraud/model/insights'
require 'minfraud/model/subscores'

module Minfraud
  module Model
    # Model representing the Factors response.
    class Factors < Insights
      # An object containing scores for many of the individual risk factors
      # that are used to calculate the overall risk score.
      #
      # @return [Minfraud::Model::Subscores]
      attr_reader :subscores

      # @!visibility private
      def initialize(record, locales)
        super

        @subscores = Minfraud::Model::Subscores.new(get('subscores'))
      end
    end
  end
end
