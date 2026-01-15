# frozen_string_literal: true

require 'minfraud/model/abstract'
require 'minfraud/model/email_domain_visit'

module Minfraud
  module Model
    # Model containing information about the email domain.
    class EmailDomain < Abstract
      # A classification of the domain. Possible values are:
      # * business
      # * education
      # * government
      # * isp_email
      #
      # @return [String, nil]
      attr_reader :classification

      # A date string (e.g. 2019-01-01) to identify the date an email domain
      # was first seen by MaxMind. This is expressed using the ISO 8601 date
      # format YYYY-MM-DD. The earliest date that may be returned is January
      # 1, 2019.
      #
      # @return [String, nil]
      attr_reader :first_seen

      # A risk score ranging from 0.01 to 99. Higher values indicate greater
      # risk.
      #
      # @return [Float, nil]
      attr_reader :risk

      # An object containing information about an automated visit to the email
      # domain.
      #
      # @return [Minfraud::Model::EmailDomainVisit, nil]
      attr_reader :visit

      # Activity across the minFraud network expressed as sightings per
      # million. The value ranges from 0.001 to 1,000,000.
      #
      # @return [Float, nil]
      attr_reader :volume

      # @!visibility private
      def initialize(record)
        super

        @classification = get('classification')
        @first_seen     = get('first_seen')
        @risk           = get('risk')
        @visit          = EmailDomainVisit.new(get('visit'))
        @volume         = get('volume')
      end
    end
  end
end
