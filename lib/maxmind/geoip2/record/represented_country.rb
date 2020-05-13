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

require 'maxmind/geoip2/record/country'

module MaxMind
  module GeoIP2
    module Record
      # Contains data for the represented country associated with an IP address.
      #
      # This class contains the country-level data associated with an IP address
      # for the IP's represented country. The represented country is the country
      # represented by something like a military base.
      #
      # See {MaxMind::GeoIP2::Record::Country} for inherited methods.
      class RepresentedCountry < Country
        # A string indicating the type of entity that is representing the country.
        # Currently we only return +military+ but this could expand to include
        # other types in the future.
        #
        # @return [String, nil]
        def type
          get('type')
        end
      end
    end
  end
end
