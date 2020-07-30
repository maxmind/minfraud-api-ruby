# frozen_string_literal: true

module Minfraud
  module Components
    class CustomInputs < Base
      # @param params [Hash] Hash with keys that match your created custom
      #   input keys.
      def initialize(params = {})
        params.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
