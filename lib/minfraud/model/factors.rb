# frozen_string_literal: true

require 'minfraud/model/insights'
require 'minfraud/model/subscores'

module Minfraud
  module Model
    # Model representing the Factors response.
    class Factors < Insights
      # An object containing subscores for many of the individual components
      # that are used to calculate the overall risk score.
      #
      # @return [Minfraud::Model::Subscores]
      attr_reader :subscores

      # @!visibility private
      def initialize(record, locales)
        super(record, locales)

        @subscores = Minfraud::Model::Subscores.new(get('subscores'))
      end
    end
  end
end
