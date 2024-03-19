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

        if YAHOO_DOMAINS.key?(domain)
          local_part.sub!(/\A([^-]+)-.*\z/, '\1')
        else
          local_part.sub!(/\A([^+]+)\+.*\z/, '\1')
        end

        if domain == 'gmail.com'
          local_part.gsub!('.', '')
        end

        domain_parts = domain.split('.')
        if domain_parts.length > 2
          possible_domain = domain_parts[1..].join('.')
          if FASTMAIL_DOMAINS.key?(possible_domain)
            domain = possible_domain
            if local_part != ''
              local_part = domain_parts[0]
            end
          end
        end

        "#{local_part}@#{domain}"
      end

      TYPO_DOMAINS = {
        # gmail.com
        'gmai.com'       => 'gmail.com',
        'gamil.com'      => 'gmail.com',
        'gmali.com'      => 'gmail.com',
        'gmial.com'      => 'gmail.com',
        'gmil.com'       => 'gmail.com',
        'gmaill.com'     => 'gmail.com',
        'gmailm.com'     => 'gmail.com',
        'gmailo.com'     => 'gmail.com',
        'gmailyhoo.com'  => 'gmail.com',
        'yahoogmail.com' => 'gmail.com',
        # outlook.com
        'putlook.com'    => 'outlook.com',
      }.freeze
      private_constant :TYPO_DOMAINS

      TYPO_TLDS = {
        'comm'   => 'com',
        'commm'  => 'com',
        'commmm' => 'com',
        'comn'   => 'com',

        'cbm'    => 'com',
        'ccm'    => 'com',
        'cdm'    => 'com',
        'cem'    => 'com',
        'cfm'    => 'com',
        'cgm'    => 'com',
        'chm'    => 'com',
        'cim'    => 'com',
        'cjm'    => 'com',
        'ckm'    => 'com',
        'clm'    => 'com',
        'cmm'    => 'com',
        'cnm'    => 'com',
        'cpm'    => 'com',
        'cqm'    => 'com',
        'crm'    => 'com',
        'csm'    => 'com',
        'ctm'    => 'com',
        'cum'    => 'com',
        'cvm'    => 'com',
        'cwm'    => 'com',
        'cxm'    => 'com',
        'cym'    => 'com',
        'czm'    => 'com',

        'col'    => 'com',
        'con'    => 'com',

        'dom'    => 'com',
        'don'    => 'com',
        'som'    => 'com',
        'son'    => 'com',
        'vom'    => 'com',
        'von'    => 'com',
        'xom'    => 'com',
        'xon'    => 'com',

        'clam'   => 'com',
        'colm'   => 'com',
        'comcom' => 'com',
      }.freeze
      private_constant :TYPO_TLDS

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

      FASTMAIL_DOMAINS = {
        '123mail.org'          => true,
        '150mail.com'          => true,
        '150ml.com'            => true,
        '16mail.com'           => true,
        '2-mail.com'           => true,
        '4email.net'           => true,
        '50mail.com'           => true,
        'airpost.net'          => true,
        'allmail.net'          => true,
        'bestmail.us'          => true,
        'cluemail.com'         => true,
        'elitemail.org'        => true,
        'emailcorner.net'      => true,
        'emailengine.net'      => true,
        'emailengine.org'      => true,
        'emailgroups.net'      => true,
        'emailplus.org'        => true,
        'emailuser.net'        => true,
        'eml.cc'               => true,
        'f-m.fm'               => true,
        'fast-email.com'       => true,
        'fast-mail.org'        => true,
        'fastem.com'           => true,
        'fastemail.us'         => true,
        'fastemailer.com'      => true,
        'fastest.cc'           => true,
        'fastimap.com'         => true,
        'fastmail.cn'          => true,
        'fastmail.co.uk'       => true,
        'fastmail.com'         => true,
        'fastmail.com.au'      => true,
        'fastmail.de'          => true,
        'fastmail.es'          => true,
        'fastmail.fm'          => true,
        'fastmail.fr'          => true,
        'fastmail.im'          => true,
        'fastmail.in'          => true,
        'fastmail.jp'          => true,
        'fastmail.mx'          => true,
        'fastmail.net'         => true,
        'fastmail.nl'          => true,
        'fastmail.org'         => true,
        'fastmail.se'          => true,
        'fastmail.to'          => true,
        'fastmail.tw'          => true,
        'fastmail.uk'          => true,
        'fastmail.us'          => true,
        'fastmailbox.net'      => true,
        'fastmessaging.com'    => true,
        'fea.st'               => true,
        'fmail.co.uk'          => true,
        'fmailbox.com'         => true,
        'fmgirl.com'           => true,
        'fmguy.com'            => true,
        'ftml.net'             => true,
        'h-mail.us'            => true,
        'hailmail.net'         => true,
        'imap-mail.com'        => true,
        'imap.cc'              => true,
        'imapmail.org'         => true,
        'inoutbox.com'         => true,
        'internet-e-mail.com'  => true,
        'internet-mail.org'    => true,
        'internetemails.net'   => true,
        'internetmailing.net'  => true,
        'jetemail.net'         => true,
        'justemail.net'        => true,
        'letterboxes.org'      => true,
        'mail-central.com'     => true,
        'mail-page.com'        => true,
        'mailandftp.com'       => true,
        'mailas.com'           => true,
        'mailbolt.com'         => true,
        'mailc.net'            => true,
        'mailcan.com'          => true,
        'mailforce.net'        => true,
        'mailftp.com'          => true,
        'mailhaven.com'        => true,
        'mailingaddress.org'   => true,
        'mailite.com'          => true,
        'mailmight.com'        => true,
        'mailnew.com'          => true,
        'mailsent.net'         => true,
        'mailservice.ms'       => true,
        'mailup.net'           => true,
        'mailworks.org'        => true,
        'ml1.net'              => true,
        'mm.st'                => true,
        'myfastmail.com'       => true,
        'mymacmail.com'        => true,
        'nospammail.net'       => true,
        'ownmail.net'          => true,
        'petml.com'            => true,
        'postinbox.com'        => true,
        'postpro.net'          => true,
        'proinbox.com'         => true,
        'promessage.com'       => true,
        'realemail.net'        => true,
        'reallyfast.biz'       => true,
        'reallyfast.info'      => true,
        'rushpost.com'         => true,
        'sent.as'              => true,
        'sent.at'              => true,
        'sent.com'             => true,
        'speedpost.net'        => true,
        'speedymail.org'       => true,
        'ssl-mail.com'         => true,
        'swift-mail.com'       => true,
        'the-fastest.net'      => true,
        'the-quickest.com'     => true,
        'theinternetemail.com' => true,
        'veryfast.biz'         => true,
        'veryspeedy.net'       => true,
        'warpmail.net'         => true,
        'xsmail.com'           => true,
        'yepmail.net'          => true,
        'your-mail.com'        => true,
      }.freeze
      private_constant :FASTMAIL_DOMAINS

      YAHOO_DOMAINS = {
        'y7mail.com'   => true,
        'yahoo.at'     => true,
        'yahoo.be'     => true,
        'yahoo.bg'     => true,
        'yahoo.ca'     => true,
        'yahoo.cl'     => true,
        'yahoo.co.id'  => true,
        'yahoo.co.il'  => true,
        'yahoo.co.in'  => true,
        'yahoo.co.kr'  => true,
        'yahoo.co.nz'  => true,
        'yahoo.co.th'  => true,
        'yahoo.co.uk'  => true,
        'yahoo.co.za'  => true,
        'yahoo.com'    => true,
        'yahoo.com.ar' => true,
        'yahoo.com.au' => true,
        'yahoo.com.br' => true,
        'yahoo.com.co' => true,
        'yahoo.com.hk' => true,
        'yahoo.com.hr' => true,
        'yahoo.com.mx' => true,
        'yahoo.com.my' => true,
        'yahoo.com.pe' => true,
        'yahoo.com.ph' => true,
        'yahoo.com.sg' => true,
        'yahoo.com.tr' => true,
        'yahoo.com.tw' => true,
        'yahoo.com.ua' => true,
        'yahoo.com.ve' => true,
        'yahoo.com.vn' => true,
        'yahoo.cz'     => true,
        'yahoo.de'     => true,
        'yahoo.dk'     => true,
        'yahoo.ee'     => true,
        'yahoo.es'     => true,
        'yahoo.fi'     => true,
        'yahoo.fr'     => true,
        'yahoo.gr'     => true,
        'yahoo.hu'     => true,
        'yahoo.ie'     => true,
        'yahoo.in'     => true,
        'yahoo.it'     => true,
        'yahoo.lt'     => true,
        'yahoo.lv'     => true,
        'yahoo.nl'     => true,
        'yahoo.no'     => true,
        'yahoo.pl'     => true,
        'yahoo.pt'     => true,
        'yahoo.ro'     => true,
        'yahoo.se'     => true,
        'yahoo.sk'     => true,
        'ymail.com'    => true,
      }.freeze
      private_constant :YAHOO_DOMAINS

      def clean_domain(domain)
        domain = domain.strip

        domain.sub!(/\.+\z/, '')

        domain = SimpleIDN.to_ascii(domain)

        domain.sub!(/(?:\.com){2,}$/, '.com')
        domain.sub!(/^\d+(?:gmail?\.com)$/, 'gmail.com')

        idx = domain.rindex('.')
        if !idx.nil?
          tld = domain[idx + 1..]
          if TYPO_TLDS.key?(tld)
            domain = "#{domain[0, idx]}.#{TYPO_TLDS[tld]}"
          end
        end

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
