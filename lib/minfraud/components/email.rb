# frozen_string_literal: true

require 'digest/md5'
require 'simpleidn'

module Minfraud
  module Components
    # Email corresponds to the email object of a minFraud request.
    #
    # @see https://dev.maxmind.com/minfraud/api-documentation/requests?lang=en#schema--request--email
    class Email < Base
      include Minfraud::Validates

      # This field must be either be a valid email address or an MD5 of the
      # lowercased email used in the transaction. Important: if using the MD5
      # hash, please be sure to convert the email address to lowercase before
      # calculating its MD5 hash. Instead of converting an address to an MD5
      # hash yourself, please use the hash_address attribute in this class.
      #
      # @return [String, nil]
      attr_accessor :address

      # The domain of the email address used in the transaction.
      #
      # @return [String, nil]
      attr_accessor :domain

      # By default, the address will be sent in plain text. If this is set
      # true, the address will instead be sent as an MD5 hash.
      #
      # @return [Boolean, nil]
      attr_accessor :hash_address

      # @param params [Hash] Hash of parameters. Each key/value should
      #   correspond to one of the available attributes.
      def initialize(params = {})
        @address      = params[:address]
        @domain       = params[:domain]
        @hash_address = params[:hash_address]

        validate
      end

      # A JSON representation of Minfraud::Components::Email.
      #
      # @return [Hash]
      def to_json(*_args)
        json = super

        if json['address'] && !json['domain']
          _, domain = address.split('@', 2)
          if domain
            domain         = clean_domain(domain)
            json['domain'] = domain if domain
          end
        end

        if json.delete('hash_address') && json['address']
          hash = hash_email_address(json['address'])

          # We could consider clearing the key if !hash.
          json['address'] = hash if hash
        end

        json
      end

      private

      def validate
        return if !Minfraud.enable_validation

        validate_email('email', @address)
        validate_string('domain', 255, @domain)
      end

      def hash_email_address(address)
        address = clean_email_address(address)
        return nil if !address

        Digest::MD5.hexdigest(address)
      end

      def clean_email_address(address)
        address = address.strip
        address.downcase!

        local_part, domain = address.split('@', 2)
        return nil if !local_part || !domain

        domain = clean_domain(domain)

        if domain == 'yahoo.com'
          local_part.sub!(/\A([^-]+)-.*\z/, '\1')
        else
          local_part.sub!(/\A([^+]+)\+.*\z/, '\1')
        end

        "#{local_part}@#{domain}"
      end

      TYPO_DOMAINS = {
        # gmail.com
        '35gmai.com'     => 'gmail.com',
        '636gmail.com'   => 'gmail.com',
        'gamil.com'      => 'gmail.com',
        'gmail.comu'     => 'gmail.com',
        'gmial.com'      => 'gmail.com',
        'gmil.com'       => 'gmail.com',
        'yahoogmail.com' => 'gmail.com',
        # outlook.com
        'putlook.com'    => 'outlook.com',
      }.freeze
      private_constant :TYPO_DOMAINS

      EQUIVALENT_DOMAINS = {
        'googlemail.com' => 'gmail.com',
        'pm.me'          => 'protonmail.com',
        'proton.me'      => 'protonmail.com',
        'yandex.by'      => 'yandex.ru',
        'yandex.com'     => 'yandex.ru',
        'yandex.kz'      => 'yandex.ru',
        'yandex.ua'      => 'yandex.ru',
        'ya.ru'          => 'yandex.ru',
      }.freeze
      private_constant :EQUIVALENT_DOMAINS

      def clean_domain(domain)
        domain = domain.strip

        # We could use delete_suffix!, but that is in Ruby 2.5+ only.
        domain.sub!(/\.\z/, '')

        domain = SimpleIDN.to_ascii(domain)

        if TYPO_DOMAINS.key?(domain)
          domain = TYPO_DOMAINS[domain]
        end

        if EQUIVALENT_DOMAINS.key?(domain)
          domain = EQUIVALENT_DOMAINS[domain]
        end

        domain
      end
    end
  end
end
