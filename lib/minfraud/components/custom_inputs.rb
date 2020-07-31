# frozen_string_literal: true

module Minfraud
  module Components
    # CustomInputs corresponds to the custom_inputs object of a minFraud
    # request.
    #
    # @see https://dev.maxmind.com/minfraud/#Custom_Inputs_(/custominputs)
    class CustomInputs < Base
      # @param params [Hash] Each key/value should correspond to your defined
      #   custom inputs.
      def initialize(params = {})
        params.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end
    end
  end
end
