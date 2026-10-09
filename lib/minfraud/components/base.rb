# frozen_string_literal: true

module Minfraud
  # Components are used to build the request to the minFraud services.
  # Each component represents a part of the transaction being analyzed,
  # such as the device, account, email, or billing address.
  module Components
    # This is a parent class for all components. It defines a method which is
    # used for basic JSON representation of the component objects.
    class Base
      # A JSON representation of component attributes.
      #
      # @return [Hash]
      def to_json(*_args)
        instance_variables.reduce({}) { |mem, e| populate!(mem, e) }
      end

      private

      # Create a hash containing a JSON representation of instance variable
      # name and its value.
      #
      # @param hash [Hash] An accumulator.
      #
      # @param v_sym [Symbol] An instance variable symbol.
      #
      # @return [Hash]
      def populate!(hash, v_sym)
        value = instance_variable_get(v_sym)
        return hash if value.nil?

        key = v_sym.to_s.gsub(/@/, '')
        hash.merge!(key => represent(value))
      end

      # Return the value according to the request format. Booleans stay
      # booleans. Other values become strings.
      #
      # @param value [Object] An instance variable value.
      #
      # @return [Object]
      def represent(value)
        [true, false].include?(value) ? value : value.to_s
      end
    end
  end
end
