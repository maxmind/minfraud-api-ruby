module Minfraud
  module Components
    # Note: This class is used as a parent class for all other components
    # It defines a method which is used for basic JSON representation of PORO objects
    class Base
      # @return [Hash] a JSON representation of component attributes
      def to_json
        instance_variables.inject({}) { |mem, e| mem.merge!(e.to_s.gsub(/@/, '') => instance_variable_get(e).to_s) }
          .delete_if { |_, v| v.empty? }
      end
    end
  end
end
