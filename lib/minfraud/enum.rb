module Minfraud
  module Enum
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Returns a hash with in the following format: attribute_name => permitted_values
      # @return [Hash] mapping
      def mapping
        @mapping ||= {}
      end

      # Creates a set of methods for enum-like behaviour of the attribute
      # @param [Symbol] attribute attribute name
      # @param [Array] assignable_values a set of values which are permitted
      def enum_accessor(attribute, assignable_values)
        mapping[attribute] = assignable_values.map(&:intern)

        self.class.instance_eval do
          define_method("#{attribute}_values") { mapping[attribute] }
        end

        self.class_eval do
          define_method("#{attribute}") { instance_variable_get("@#{attribute}") }
          define_method "#{attribute}=" do |value|
            raise NotEnumValueError,  'Value is not permitted' if value && !self.class.mapping[attribute].include?(value.intern)
            instance_variable_set("@#{attribute}", value ? value.intern : nil)
          end
        end
      end
    end
  end
end
