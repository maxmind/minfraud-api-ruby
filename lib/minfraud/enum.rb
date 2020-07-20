# frozen_string_literal: true

module Minfraud
  module Enum
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Returns a hash in the following format: attribute_name =>
      # permitted_values
      #
      # @return [Hash]
      def mapping
        @mapping ||= {}
      end

      # Creates a set of methods for enum-like behavior of the attribute.
      #
      # @param attribute [Symbol] The attribute name.
      #
      # @param assignable_values [Array] The set of permitted values.
      #
      # @return [nil]
      def enum_accessor(attribute, assignable_values)
        mapping[attribute] = assignable_values.map(&:intern)

        self.class.instance_eval do
          define_method("#{attribute}_values") { mapping[attribute] }
        end

        class_eval do
          define_method(attribute.to_s) { instance_variable_get("@#{attribute}") }
          define_method "#{attribute}=" do |value|
            raise NotEnumValueError, 'Value is not permitted' if value && !self.class.mapping[attribute].include?(value.intern)

            instance_variable_set("@#{attribute}", value ? value.intern : nil)
          end
        end

        nil
      end
    end
  end
end
