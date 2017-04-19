require 'json'

module Minfraud
  module Representable
    def self.included(base)
      base.extend         Forwardable
      base.def_delegators :as_json, :to_json
    end

    def as_json
      instance_values.reject { |_, v| v.nil? }
    end

    private

    def instance_values
      Hash[instance_variables.map { |name| [name.to_s[1..-1], instance_variable_get(name)] }]
    end
  end
end
