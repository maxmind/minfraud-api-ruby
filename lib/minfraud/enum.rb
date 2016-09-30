module Minfraud
  module Enum

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def mapping
        @mapping ||= {}
      end

      def assignable_values_for(attribute)
        return mapping[attribute] unless mapping[attribute].is_a?(Hash)
        return mapping[attribute].keys
      end

      def enum_accessor(attribute, assignable_values)
        mapping[attribute] = assignable_values

        self.instance_eval do
          define_method "#{attribute}" do
            self.instance_variable_get("@#{attribute}")
          end

          define_method "#{attribute}=" do |value|
            raise NotEnumValueError, 'This value is not permitted' unless self.class.assignable_values_for(attribute).include?(value)
            self.instance_variable_set("@#{attribute}", value)
          end
        end

        self.singleton_class.class_eval do
          define_method "#{attribute}_values" do
            assignable_values_for(attribute)
          end
        end
      end
    end
  end
end
