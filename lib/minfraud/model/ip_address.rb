# frozen_string_literal: true

require 'maxmind/geoip2/model/insights'
require 'minfraud/model/geoip2_location'
require 'minfraud/model/ip_risk_reason'

module Minfraud
  module Model
    # Model containing GeoIP2 data and the risk for the IP address.
    class IPAddress < MaxMind::GeoIP2::Model::Insights
      # This field contains the risk associated with the IP address. The value
      # ranges from 0.01 to 99. A higher score indicates a higher risk.
      #
      # @return [Float]
      attr_reader :risk

      # This field contains IPRiskReason objects identifying the reasons why
      # the IP address received the associated risk. This will be an empty
      # array if there are no reasons.
      #
      # @return [Array<Minfraud::Model::IPRiskReason>]
      attr_reader :risk_reasons

      # @!visibility private
      def initialize(record, locales)
        if record
          super(record, locales)
        else
          super({}, locales)
        end

        if record
          @location = Minfraud::Model::GeoIP2Location.new(record.fetch('location', nil))
        else
          @location = Minfraud::Model::GeoIP2Location.new(nil)
        end
        if record
          @risk = record.fetch('risk', nil)
        else
          @risk = nil
        end

        @risk_reasons = []
        if record&.key?('risk_reasons')
          record['risk_reasons'].each do |r|
            @risk_reasons << Minfraud::Model::IPRiskReason.new(r)
          end
        end

        # Mashify turned each language code into an attribute, but
        # maxmind-geoip2 exposes the names as a hash.
        LANGUAGE_CODES.each do |c|
          @city.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          @continent.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          @country.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          @registered_country.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          @represented_country.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          @subdivisions.each do |s|
            s.names&.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
        end

        # This attribute is deprecated.
        @country.define_singleton_method(:is_high_risk) { get('is_high_risk') }

        # These attributes are deprecated and aren't in maxmind-geoip2.
        @traits.define_singleton_method(:is_anonymous_proxy) { get('is_anonymous_proxy') }
        @traits.define_singleton_method(:is_satellite_provider) { get('is_satellite_provider') }
      end

      LANGUAGE_CODES = %i[de en es fr ja pt-BR ru zh-CN].freeze
    end
  end
end
