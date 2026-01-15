# frozen_string_literal: true

require 'minfraud/model/abstract'
require 'minfraud/model/email_domain'

module Minfraud
  module Model
    # Model containing information about the email address.
    class Email < Abstract
      # An object containing information about the email domain.
      #
      # @return [Minfraud::Model::EmailDomain]
      attr_reader :domain

      # A date string (e.g. 2017-04-24) to identify the date an email address
      # was first seen by MaxMind. This is expressed using the ISO 8601 date
      # format YYYY-MM-DD. The earliest date that may be returned is January
      # 1, 2008.
      #
      # @return [String, nil]
      attr_reader :first_seen

      # Whether this email address is from a disposable email provider. The
      # value will be nil when no email address or email domain has been passed
      # as an input.
      #
      # @return [Boolean, nil]
      attr_reader :is_disposable

      # This property is true if MaxMind believes that this email is hosted by
      # a free email provider such as Gmail or Yahoo! Mail.
      #
      # @return [Boolean, nil]
      attr_reader :is_free

      # This field is true if MaxMind believes that this email is likely to be
      # used for fraud. Note that this is also factored into the overall
      # risk_score in the response as well.
      #
      # @return [Boolean, nil]
      attr_reader :is_high_risk

      # @!visibility private
      def initialize(record)
        super

        @domain        = Minfraud::Model::EmailDomain.new(get('domain'))
        @first_seen    = get('first_seen')
        @is_disposable = get('is_disposable')
        @is_free       = get('is_free')
        @is_high_risk  = get('is_high_risk')
      end
    end
  end
end
