# frozen_string_literal: true

module Minfraud
  module Components
    # @note This class is used as a parent class for all other components
    # @note It defines a method which is used for basic JSON representation of PORO objects
    class Base
      # @return [Hash] a JSON representation of component attributes
      def to_json(*_args)
        instance_variables.reduce({}) { |mem, e| populate!(mem, e) }
      end

      private

      # @note   This method may modify passed hash. Non-existing instance variables are ignored
      # @param  [Hash] hash an accumulator
      # @param  [Symbol] v_sym an instance variable symbol
      # @return [Hash] a hash containing a JSON representation of instance variable name and it's value
      def populate!(hash, v_sym)
        return hash unless value = instance_variable_get(v_sym)

        key = v_sym.to_s.gsub(/@/, '')
        hash.merge!(key => represent(key, value))
      end

      # param [Symbol] key instance variable symbol
      # param [Object] value instance variable value
      # @return [Object] value representation according to the request format
      def represent(key, value)
        BOOLS.include?(key) ? value : value.to_s
      end

      # Keys that have to remain boolean
      BOOLS = %w[was_authorized is_gift has_gift_message].freeze
    end
  end
end
