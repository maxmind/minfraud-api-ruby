module Minfraud
  module Components
    class CustomInputs < Base
      # Creates Minfraud::Components::CustomInputs instance
      # @param  [Hash] params hash with keys that match your created custom input keys
      # @return [Minfraud::Components::CustomInputs] a CustomInputs instance
      def initialize(params = {})
        params.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
