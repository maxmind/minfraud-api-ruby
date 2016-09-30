module Minfraud
  module Enum
    def self.included(base)
      base.extend(ClassMethods)
    end

    class Accessor
      attr_reader   :assignable_values
      attr_accessor :current_value

      def initialize(assignable_values)
        @assignable_values = assignable_values
      end

      def value
        assignable_values[current_value]
      end

      def to_s
        value.to_s
      end
    end

    module ClassMethods
      def mapping
        @mapping ||= {}
      end

      def enum_accessor(attribute, assignable_values)
        mapping[attribute] = Accessor.new(assignable_values)

        self.class.instance_eval do
          define_method "#{attribute}_values" do
            mapping[attribute].assignable_values
          end
        end

        self.class_eval do
          define_method "#{attribute}" do
            self.class.mapping[attribute]
          end

          define_method "#{attribute}=" do |value|
            raise NotEnumValueError,  'Value is not permitted' unless self.class.mapping[attribute].assignable_values.include?(value)
            self.class.mapping[attribute].current_value = value
          end
        end
      end
    end
  end
end
