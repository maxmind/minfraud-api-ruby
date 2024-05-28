# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model containing information about the email domain.
    class EmailDomain < Abstract
      # A date string (e.g. 2017-04-24) to identify the date an email domain
      # was first seen by MaxMind. This is expressed using the ISO 8601 date
      # format.
      #
      # @return [String, nil]
      attr_reader :first_seen

      # @!visibility private
      def initialize(record)
        super

        @first_seen = get('first_seen')
      end
    end
  end
end
