# frozen_string_literal: true

require 'maxmind/geoip2/model/insights'
require 'minfraud/model/geoip2_location'

module Minfraud
  module Model
    # Model containing GeoIP2 data and the risk for the IP address.
    class IPAddress < MaxMind::GeoIP2::Model::Insights
      # This field contains the risk associated with the IP address. The value
      # ranges from 0.01 to 99. A higher score indicates a higher risk.
      #
      # @return [Float]
      attr_reader :risk

      # @!visibility private
      def initialize(record, locales)
        super(record, locales)

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

        # Decorate objects with deprecated attributes and names for backwards
        # compatibility. Do this here rather than with the overhead of
        # subclasses/modules for them in the hope that one day we can delete
        # them.

        # These are named differently in maxmind-geoip2.
        @country.define_singleton_method(:is_in_european_union) { in_european_union? }
        @registered_country.define_singleton_method(:is_in_european_union) { in_european_union? }
        @represented_country.define_singleton_method(:is_in_european_union) { in_european_union? }
        @traits.define_singleton_method(:is_anonymous) { anonymous? }
        @traits.define_singleton_method(:is_anonymous_vpn) { anonymous_vpn? }
        @traits.define_singleton_method(:is_hosting_provider) { hosting_provider? }
        @traits.define_singleton_method(:is_public_proxy) { public_proxy? }
        @traits.define_singleton_method(:is_tor_exit_node) { tor_exit_node? }

        # Mashify turned each language code into an attribute, but
        # maxmind-geoip2 exposes the names as a hash.
        LANGUAGE_CODES.each do |c|
          if @city.names
            @city.names.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
          if @continent.names
            @continent.names.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
          if @country.names
            @country.names.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
          if @registered_country.names
            @registered_country.names.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
          if @represented_country.names
            @represented_country.names.define_singleton_method(c) { fetch(c.to_s, nil) }
          end
          @subdivisions.each do |s|
            if s.names
              s.names.define_singleton_method(c) { fetch(c.to_s, nil) }
            end
          end
        end

        # This attribute is deprecated.
        @country.define_singleton_method(:is_high_risk) { get('is_high_risk') }

        # These attributes are deprecated and aren't in maxmind-geoip2.
        @traits.define_singleton_method(:is_anonymous_proxy) { get('is_anonymous_proxy') }
        @traits.define_singleton_method(:is_satellite_provider) { get('is_satellite_provider') }
      end

      LANGUAGE_CODES = ['de', 'en', 'es', 'fr', 'ja', 'pt-BR', 'ru', 'zh-CN'].freeze
    end
  end
end
