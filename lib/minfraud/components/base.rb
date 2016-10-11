module Minfraud
  module Components
    # @note This class is used as a parent class for all other components
    # @note It defines a method which is used for basic JSON representation of PORO objects
    class Base
      # @return [Hash] a JSON representation of component attributes
      def to_json
        instance_variables.inject({}) { |mem, e| populate!(mem, e) }
      end

      private

      # @note   This method may modify passed hash. Non-existing instance variables are ignored
      # @param  [Hash] hash an accumulator
      # @param  [Symbol] v_sym an instance variable symbol
      # @return [Hash] a hash containing a JSON representation of instance variable name and it's value
      def populate!(hash, v_sym)
        return hash unless value = instance_variable_get(v_sym)
        hash.merge!(v_sym.to_s.gsub(/@/, '') => value.to_s)
      end
    end
  end
end
