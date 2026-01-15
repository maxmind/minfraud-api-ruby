# frozen_string_literal: true

require 'date'
require 'ipaddr'
require 'uri'

# rubocop:disable Metrics/ModuleLength
module Minfraud
  # @!visibility private
  # Validates provides validation helper methods for component input values.
  # These methods are used internally when validation is enabled via
  # Minfraud.enable_validation.
  module Validates
    # Validates that a string value does not exceed a maximum length.
    #
    # @param field [String] The field name for error messages.
    # @param length [Integer] The maximum allowed length.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value exceeds the maximum length.
    #
    # @return [nil]
    def validate_string(field, length, value)
      return if !value

      if value.to_s.length > length
        raise InvalidInputError, "The #{field} value is not valid. The maximum length is #{length}."
      end
    end

    # Validates that a value is a valid MD5 hash string.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid MD5 hash.
    #
    # @return [nil]
    def validate_md5(field, value)
      return if !value

      if !value.to_s.match(/\A[a-fA-F0-9]{32}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an MD5 hash as a string."
      end
    end

    # Validates that a value is a valid UUID string.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid UUID.
    #
    # @return [nil]
    def validate_uuid(field, value)
      return if !value

      stripped_value = value.to_s.delete('-')

      # Define a regex pattern for a valid UUID without dashes
      uuid_regex = /\A[0-9a-f]{32}\z/i

      unless uuid_regex.match(stripped_value)
        raise InvalidInputError, "The #{field} value is not valid. It must be a UUID string."
      end
    end

    # Validates that a value is a valid ISO 3166-2 subdivision code.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid subdivision code.
    #
    # @return [nil]
    def validate_subdivision_code(field, value)
      return if !value

      if !value.to_s.match(/\A[0-9A-Z]{1,4}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an ISO 3166-2 subdivision code."
      end
    end

    # Validates that a value is a valid ISO 3166-1 alpha-2 country code.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid country code.
    #
    # @return [nil]
    def validate_country_code(field, value)
      return if !value

      if !value.to_s.match(/\A[A-Z]{2}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be an ISO 3166-1 alpha-2 country code."
      end
    end

    # Validates that a value is a valid telephone country code (1-4 digits).
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid telephone country
    #   code.
    #
    # @return [nil]
    def validate_telephone_country_code(field, value)
      return if !value

      if !value.to_s.match(/\A[0-9]{1,4}\z/)
        raise InvalidInputError, "The #{field} value is not valid. It must be at most 4 digits."
      end
    end

    # Validates that a value matches a regular expression pattern.
    #
    # @param field [String] The field name for error messages.
    # @param regex [Regexp] The regular expression pattern to match.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value does not match the pattern.
    #
    # @return [nil]
    def validate_regex(field, regex, value)
      return if !value

      if !regex.match(value.to_s)
        raise InvalidInputError, "The #{field} value is not valid. It must match the pattern #{regex}."
      end
    end

    # Validates that a value is a valid credit card token.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid credit card token.
    #
    # @return [nil]
    def validate_credit_card_token(field, value)
      return if !value

      s = value.to_s

      if !/\A[\x21-\x7E]{1,255}\z/.match(s)
        raise InvalidInputError, "The #{field} value is not valid. It must contain only non-space printable ASCII characters."
      end

      if /\A[0-9]{1,19}\z/.match?(s)
        raise InvalidInputError, "The #{field} value is not valid. If it is all digits, it must be longer than 19 characters."
      end
    end

    # Validates a custom input value (boolean, numeric, or string).
    #
    # @param field [String] The field name for error messages.
    # @param value [Boolean, Numeric, String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not valid.
    #
    # @return [nil]
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

    # Validates that a value is a valid IPv4 or IPv6 address.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid IP address.
    #
    # @return [nil]
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

    # Validates that a value is a non-negative number within range.
    #
    # @param field [String] The field name for error messages.
    # @param value [Numeric, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid non-negative
    #   number.
    #
    # @return [nil]
    def validate_nonnegative_number(field, value)
      return if !value

      if !value.is_a? Numeric
        raise InvalidInputError, "The #{field} value is not valid. It must be numeric."
      end

      if value.negative? || value > 1e13 - 1
        raise InvalidInputError, "The #{field} value is not valid. It must be at least 0 and at most 1e13 - 1."
      end
    end

    # Validates that a value is a non-negative integer within range.
    #
    # @param field [String] The field name for error messages.
    # @param value [Integer, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid non-negative
    #   integer.
    #
    # @return [nil]
    def validate_nonnegative_integer(field, value)
      return if !value

      if !value.is_a? Integer
        raise InvalidInputError, "The #{field} is not valid. It must be an integer."
      end

      if value.negative? || value > 1e13 - 1
        raise InvalidInputError, "The #{field} is not valid. It must be at least 0 and at most 1e13 - 1."
      end
    end

    # Validates that a value is a valid email address or MD5 hash of one.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid email or MD5 hash.
    #
    # @return [nil]
    def validate_email(field, value)
      return if !value

      if /.@./.match?(value)
        validate_string(field, 255, value)
        return
      end

      validate_md5(field, value)
    end

    # Validates that a value is in RFC 3339 date-time format.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not in RFC 3339 format.
    #
    # @return [nil]
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

    # Validates that a value is a boolean.
    #
    # @param field [String] The field name for error messages.
    # @param value [Boolean, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a boolean.
    #
    # @return [nil]
    def validate_boolean(field, value)
      return if !value

      if ![false, true].include? value
        raise InvalidInputError, "The #{field} value is not valid. It must be boolean."
      end
    end

    # Validates that a value is a valid absolute URI.
    #
    # @param field [String] The field name for error messages.
    # @param value [String, nil] The value to validate.
    #
    # @raise [InvalidInputError] If the value is not a valid absolute URI.
    #
    # @return [nil]
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
