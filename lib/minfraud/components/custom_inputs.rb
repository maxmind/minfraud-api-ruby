# frozen_string_literal: true

module Minfraud
  module Components
    # CustomInputs corresponds to the custom_inputs object of a minFraud
    # request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--custom-inputs
    class CustomInputs < Base
      include Minfraud::Validates

      # @param params [Hash] Each key/value should correspond to your defined
      #   custom inputs.
      def initialize(params = {})
        params.each do |name, value|
          instance_variable_set("@#{name}", value)

          if Minfraud.enable_validation
            validate_custom_input_value(name, value)
          end
        end
      end
    end
  end
end
