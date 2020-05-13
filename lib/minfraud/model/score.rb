# frozen_string_literal: true

require 'minfraud/model/abstract'
require 'minfraud/model/disposition'
require 'minfraud/model/score_ip_address'
require 'minfraud/model/warning'

module Minfraud
  module Model
    # Model of the Score response.
    class Score < Abstract
      # An object containing the disposition set by custom rules.
      #
      # @return [Minfraud::Model::Disposition]
      attr_reader :disposition

      # The approximate US dollar value of the funds remaining on your MaxMind
      # account.
      #
      # @return [Float]
      attr_reader :funds_remaining

      # This is a UUID that identifies the minFraud request. Please use this ID
      # in bug reports or support requests to MaxMind so that we can easily
      # identify a particular request.
      #
      # @return [String]
      attr_reader :id

      # An object containing the IP risk for the transaction.
      #
      # @return [Minfraud::Model::ScoreIPAddress]
      attr_reader :ip_address

      # The approximate number of queries remaining for this service before
      # your account runs out of funds.
      #
      # @return [Integer]
      attr_reader :queries_remaining

      # This property contains the risk score, from 0.01 to 99. A higher score
      # indicates a higher risk of fraud. For example, a score of 20 indicates
      # a 20% chance that a transaction is fraudulent. We never return a risk
      # score of 0, since all transactions have the possibility of being
      # fraudulent. Likewise we never return a risk score of 100.
      #
      # @return [Float]
      attr_reader :risk_score

      # This array contains objects detailing issues with the request that was
      # sent, such as invalid or unknown inputs. It is highly recommended that
      # you check this array for issues when integrating the web service.
      #
      # @return [Array<Minfraud::Model::Warning>]
      attr_reader :warnings

      # @!visibility private
      def initialize(record, _locales)
        super(record)

        @disposition = Minfraud::Model::Disposition.new(get('disposition'))
        @funds_remaining = get('funds_remaining')
        @id = get('id')
        @ip_address = Minfraud::Model::ScoreIPAddress.new(get('ip_address'))
        @queries_remaining = get('queries_remaining')
        @risk_score = get('risk_score')
        @warnings = []
        if record && record.key?('warnings')
          record['warnings'].each do |w|
            @warnings << Minfraud::Model::Warning.new(w)
          end
        end
      end
    end
  end
end
