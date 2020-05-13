# Copyright (c) 2020 by MaxMind, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# frozen_string_literal: true

require 'maxmind/geoip2/record/abstract'

module MaxMind
  module GeoIP2
    module Record
      # Contains data for the location record associated with an IP address.
      #
      # This record is returned by all location services and databases besides
      # Country.
      class Location < Abstract
        # The approximate accuracy radius in kilometers around the latitude and
        # longitude for the IP address. This is the radius where we have a 67%
        # confidence that the device using the IP address resides within the circle
        # centered at the latitude and longitude with the provided radius.
        #
        # @return [Integer, nil]
        def accuracy_radius
          get('accuracy_radius')
        end

        # The average income in US dollars associated with the requested IP
        # address. This attribute is only available from the Insights service.
        #
        # @return [Integer, nil]
        def average_income
          get('average_income')
        end

        # The approximate latitude of the location associated with the IP address.
        # This value is not precise and should not be used to identify a particular
        # address or household.
        #
        # @return [Float, nil]
        def latitude
          get('latitude')
        end

        # The approximate longitude of the location associated with the IP address.
        # This value is not precise and should not be used to identify a particular
        # address or household.
        #
        # @return [Float, nil]
        def longitude
          get('longitude')
        end

        # The metro code of the location if the location is in the US. MaxMind
        # returns the same metro codes as the Google AdWords API. See
        # https://developers.google.com/adwords/api/docs/appendix/cities-DMAregions.
        #
        # @return [Integer, nil]
        def metro_code
          get('metro_code')
        end

        # The estimated population per square kilometer associated with the IP
        # address. This attribute is only available from the Insights service.
        #
        # @return [Integer, nil]
        def population_density
          get('population_density')
        end

        # The time zone associated with location, as specified by the IANA Time
        # Zone Database, e.g., "America/New_York". See
        # https://www.iana.org/time-zones.
        #
        # @return [String, nil]
        def time_zone
          get('time_zone')
        end
      end
    end
  end
end
