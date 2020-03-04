# frozen_string_literal: true

module Minfraud
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
