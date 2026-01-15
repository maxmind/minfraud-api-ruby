# frozen_string_literal: true

module Minfraud
  # Model contains classes for the minFraud response data. These classes
  # represent the data returned by the Score, Insights, and Factors
  # endpoints.
  module Model
    # @!visibility private
    class Abstract
      def initialize(record)
        @record = record
      end

      protected

      def get(key)
        return nil if @record.nil? || !@record.key?(key)

        @record[key]
      end
    end
  end
end
