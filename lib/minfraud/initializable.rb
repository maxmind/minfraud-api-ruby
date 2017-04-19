module Minfraud
  module Initializable
    def self.included(base)
      base.extend ClassMethods
    end

    def initialize(params = {})
      self.class.accessors.each do |name|
        send :"#{name}=", params[name]
      end
    end

    module ClassMethods
      def accessors
        @accessors ||= []
      end

      def attr_accessor(*args)
        accessors.push(*args)

        super
      end
    end
  end
end
