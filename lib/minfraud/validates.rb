# frozen_string_literal: true

require 'date'
require 'ipaddr'
require 'uri'

# rubocop:disable Metrics/ModuleLength
module Minfraud
  # @!visibility private
  module Validates
    def validate_string(field, length, value)
      return if !value

      if value.to_s.length > length
        raise InvalidInputError, "The #{field} value is not valid. The maximum length is #{length}."
      end
    end

    def validate_md5(field, value)
      return if !value

      if !value.to_s.match(/\A[a-fA-F0-9]{32}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an MD5 hash as a string."
      end
    end

    def validate_subdivision_code(field, value)
      return if !value

      if !value.to_s.match(/\A[0-9A-Z]{1,4}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an ISO 3166-2 subdivision code."
      end
    end

    def validate_country_code(field, value)
      return if !value

      if !value.to_s.match(/\A[A-Z]{2}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an ISO 3166-1 alpha-2 country code."
      end
    end

    def validate_telephone_country_code(field, value)
      return if !value

      if !value.to_s.match(/\A[0-9]{1,4}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be at most 4 digits."
      end
    end

    def validate_regex(field, regex, value)
      return if !value

      if !regex.match(value.to_s)
        raise InvalidInputError, "The #{field} value is not valid. It must match the pattern #{regex}."
      end
    end

    def validate_credit_card_token(field, value)
      return if !value

      s = value.to_s

      if !/\A[\x21-\x7E]{1,255}\z/.match(s)
        raise InvalidInputError, "The #{field} value is not valid. It must contain only non-space printable ASCII characters."
      end

      if /\A[0-9]{1,19}\z/.match(s)
        raise InvalidInputError, "The #{field} value is not valid. If it is all digits, it must be longer than 19 characters."
      end
    end

    def validate_custom_input_value(field, value)
      return if !value

      if [true, false].include?(value)
        return
      end

      if value.is_a? Numeric
        if value < -1e13 + 1 || value > 1e13 - 1
          raise InvalidInputError, "The #{field} value is not valid. Numeric values must be between -1e13 and 1e13."
        end

        return
      end

      validate_string(field, 255, value)
    end

    def validate_ip(field, value)
      return if !value

      s = value.to_s
      if s.include? '/'
        raise InvalidInputError, "The #{field} value is not valid. It must be an individual IP address."
      end

      # rubocop:disable Style/RescueStandardError
      begin
        IPAddr.new(s)
      rescue
        raise InvalidInputError, "The #{field} value is not valid. It must be an IPv4 or IPv6 address."
      end
      # rubocop:enable Style/RescueStandardError

      nil
    end

    def validate_nonnegative_number(field, value)
      return if !value

      if !value.is_a? Numeric
        raise InvalidInputError, "The #{field} value is not valid. It must be numeric."
      end

      if value.negative? || value > 1e13 - 1
        raise InvalidInputError, "The #{field} value is not valid. It must be at least 0 and at most 1e13 - 1."
      end
    end

    def validate_nonnegative_integer(field, value)
      return if !value

      if !value.is_a? Integer
        raise InvalidInputError, "The #{field} is not valid. It must be an integer."
      end

      if value.negative? || value > 1e13 - 1
        raise InvalidInputError, "The #{field} is not valid. It must be at least 0 and at most 1e13 - 1."
      end
    end

    def validate_email(field, value)
      return if !value

      if /.@./.match(value)
        validate_string(field, 255, value)
        return
      end

      validate_md5(field, value)
    end

    def validate_rfc3339(field, value)
      return if !value

      # rubocop:disable Style/RescueStandardError
      begin
        DateTime.rfc3339(value)
      rescue
        raise InvalidInputError, "The #{field} value is not valid. It must be in the RFC 3339 date-time format."
      end
      # rubocop:enable Style/RescueStandardError

      nil
    end

    def validate_boolean(field, value)
      return if !value

      if ![false, true].include? value
        raise InvalidInputError, "The #{field} value is not valid. It must be boolean."
      end
    end

    def validate_uri(field, value)
      return if !value

      if value.to_s.length > 1_024
        raise InvalidInputError, "The #{field} value is not valid. It must not exceed 1024 characters."
      end

      # rubocop:disable Style/RescueStandardError
      begin
        u = URI(value)
        if !u.scheme
          raise InvalidInputError
        end
      rescue
        raise InvalidInputError, "The #{field} value is not valid. It must be an absolute URI."
      end
      # rubocop:enable Style/RescueStandardError
    end
  end
end
# rubocop:enable Metrics/ModuleLength
