# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model with the disposition set by custom rules.
    #
    # In order to receive a disposition, you must be using minFraud custom
    # rules.
    class Disposition < Abstract
      # The action to take on the transaction as defined by your custom rules.
      # The current set of values are "accept", "manual_review", and "reject".
      # If you do not have custom rules set up, this will be nil.
      #
      # @return [String, nil]
      attr_reader :action

      # The reason for the action. The current possible values are
      # "custom_rule", "block_list", and "default". If you do not have custom
      # rules set up, this will be nil.
      #
      # @return [String, nil]
      attr_reader :reason

      # @!visibility private
      def initialize(record)
        super(record)

        @action = get('action')
        @reason = get('reason')
      end
    end
  end
end
