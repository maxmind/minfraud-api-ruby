# frozen_string_literal: true

module Minfraud
  # Enum provides helpers for working with attributes with enumerated types.
  module Enum
    # Hook method called when the module is included into a class.
    # Extends the class with ClassMethods.
    #
    # @param base [Class] The class including this module.
    #
    # @return [Class] The base class.
    def self.included(base)
      base.extend(ClassMethods)
    end

    # ClassMethods provides helpers for working with attributes with enumerated
    # types.
    module ClassMethods
      # Returns a hash in the following format: attribute_name =>
      # permitted_values. It includes the attributes declared on parent
      # classes.
      #
      # @return [Hash]
      def mapping
        # rubocop:disable ThreadSafety/ClassInstanceVariable
        # This is a false positive - this only reads the mapping that
        # enum_accessor sets during class definition
        declared = @declared_mapping || {}
        # rubocop:enable ThreadSafety/ClassInstanceVariable

        if superclass.respond_to?(:mapping)
          superclass.mapping.merge(declared)
        else
          declared.dup
        end
      end

      # Create a set of methods for enum-like behavior of the attribute.
      #
      # @param attribute [Symbol] The attribute name.
      #
      # @param assignable_values [Array] The set of permitted values.
      #
      # @return [nil]
      def enum_accessor(attribute, assignable_values)
        values                      = assignable_values.map(&:intern).freeze
        declared_mapping[attribute] = values

        define_singleton_method("#{attribute}_values") { values }

        class_eval do
          define_method(attribute.to_s) { instance_variable_get("@#{attribute}") }
          define_method "#{attribute}=" do |value|
            value = value.intern if value.is_a?(String)
            raise NotEnumValueError, 'Value is not permitted' if !value.nil? && !values.include?(value)

            instance_variable_set("@#{attribute}", value)
          end
        end

        nil
      end

      private

      def declared_mapping
        # rubocop:disable ThreadSafety/ClassInstanceVariable
        # This is a false positive - only enum_accessor calls this, during class
        # definition
        @declared_mapping ||= {}
        # rubocop:enable ThreadSafety/ClassInstanceVariable
      end
    end
  end
end
