# frozen_string_literal: true

require 'maxmind/geoip2/record/location'

module Minfraud
  module Model
    # Model of the GeoIP2 location information, including the local time.
    class GeoIP2Location < MaxMind::GeoIP2::Record::Location
      # The date and time of the transaction in the time zone associated with
      # the IP address. The value is formatted according to RFC 3339. For
      # instance, the local time in Boston might be returned as
      # 2015-04-27T19:17:24-04:00.
      #
      # @return [String]
      attr_reader :local_time

      # @!visibility private
      def initialize(record)
        super(record)

        @local_time = get('local_time')
      end
    end
  end
end
