module Minfraud
  module Enum
    def enum_accessor(name, values)
      attr_accessor name

      define_singleton_method "#{name}s" do
        values
      end

      define_method "#{name}=" do |value|
        return unless value

        unless values.include?(value)
          raise NotEnumValueError
        else
          instance_variable_set "@#{name}", value
        end
      end
    end
  end
end
