module Minfraud
  module Enum
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def mapping
        @mapping ||= {}
      end

      def enum_accessor(attribute, assignable_values)
        mapping[attribute] = assignable_values.map(&:to_s)

        self.class.instance_eval do
          define_method("#{attribute}_values") { mapping[attribute] }
        end

        self.class_eval do
          define_method("#{attribute}") { instance_variable_get("@#{attribute}") }

          define_method "#{attribute}=" do |value|
            raise NotEnumValueError,  'Value is not permitted' unless self.class.mapping[attribute].include?(value.to_s)
            instance_variable_set("@#{attribute}", value.to_s)
          end
        end
      end
    end
  end
end
