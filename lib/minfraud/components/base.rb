# frozen_string_literal: true

module Minfraud
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
        return hash unless (value = instance_variable_get(v_sym))

        key = v_sym.to_s.gsub(/@/, '')
        hash.merge!(key => represent(key, value))
      end

      # Return the value according to the request format.
      #
      # @param key [Symbol] An instance variable symbol.
      #
      # @param value [Object] An instance variable value.
      #
      # @return [Object]
      def represent(key, value)
        BOOLS.include?(key) ? value : value.to_s
      end

      # Keys that have to remain boolean
      BOOLS = %w[was_authorized is_gift has_gift_message].freeze

      private_constant :BOOLS
    end
  end
end
