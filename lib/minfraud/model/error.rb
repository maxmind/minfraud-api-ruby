# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model with information about an error.
    class Error < Abstract
      # An error code for machine use.
      #
      # @return [String]
      attr_reader :code

      # A human readable error message.
      #
      # @return [String]
      attr_reader :error

      # @!visibility private
      def initialize(record)
        super(record)

        @code = get('code')
        @error = get('error')
      end
    end
  end
end
