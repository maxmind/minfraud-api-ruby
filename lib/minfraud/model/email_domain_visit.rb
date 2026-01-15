# frozen_string_literal: true

require 'minfraud/model/abstract'

module Minfraud
  module Model
    # Model containing information about an automated visit to the email
    # domain.
    class EmailDomainVisit < Abstract
      # This is true if the domain in the request has redirects (configured
      # to automatically send visitors to another URL). Otherwise, this will
      # be nil.
      #
      # @return [Boolean, nil]
      attr_reader :has_redirect

      # A date string (e.g. 2025-11-15) identifying the date the automated
      # visit was completed. This is expressed using the ISO 8601 date format.
      #
      # @return [String, nil]
      attr_reader :last_visited_on

      # The status of the domain. Possible values are:
      # * live - The domain is reachable and serving content normally.
      # * dns_error - The domain is missing, expired, or DNS is misconfigured.
      # * network_error - The domain is offline, blocked, or unreachable.
      # * http_error - The domain is reachable but the web application had a
      #   problem or denied the request.
      # * parked - The domain is live and is in a parked state.
      # * pre_development - The domain is live and is in a pre-development
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
