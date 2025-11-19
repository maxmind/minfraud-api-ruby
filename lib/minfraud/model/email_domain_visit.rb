# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model containing information about an automated visit to the email
    # domain.
    class EmailDomainVisit < Abstract
      # Whether the domain redirects to another URL.
      #
      # @return [Boolean, nil]
      attr_reader :has_redirect

      # A date string (e.g. 2025-11-15) identifying the date the automated
      # visit was completed. This is expressed using the ISO 8601 date format.
      #
      # @return [String, nil]
      attr_reader :last_visited_on

      # The status of the domain. Possible values are:
      # * live - The domain is operational and serving content.
      # * dns_error - The domain has missing, expired, or misconfigured DNS.
      # * network_error - The domain is offline or unreachable.
      # * http_error - The domain is reachable, but has an application error.
      # * parked - The domain is reachable and in a parked state.
      # * pre_development - The domain is reachable and in a pre-development
      #   state.
      #
      # @return [String, nil]
      attr_reader :status

      # @!visibility private
      def initialize(record)
        super

        @has_redirect    = get('has_redirect')
        @last_visited_on = get('last_visited_on')
        @status          = get('status')
      end
    end
  end
end
