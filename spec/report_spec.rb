# frozen_string_literal: true

require 'spec_helper'

describe 'Minfraud::Components::Report::Transaction' do
  describe 'new' do
    it 'does not throw an exception when a transaction param is given' do
      txn    = Minfraud::Components::Report::Transaction.new(
        ip_address:      '1.2.3.4',
        tag:             :suspected_fraud,
        chargeback_code: 'some code',
        maxmind_id:      '12345678',
        minfraud_id:     '58fa38d8-4b87-458b-a22b-f00eda1aa20d',
        notes:           'notes go here',
        transaction_id:  '1FA254yZ'
      )
      report = Minfraud::Report.new(transaction: txn)
      expect(report.transaction.to_json['ip_address']).to eq('1.2.3.4')
      expect(report.transaction.to_json['tag']).to eq('suspected_fraud')
      expect(report.transaction.to_json['chargeback_code']).to eq('some code')
      expect(report.transaction.to_json['maxmind_id']).to eq('12345678')
      expect(report.transaction.to_json['minfraud_id']).to eq('58fa38d8-4b87-458b-a22b-f00eda1aa20d')
      expect(report.transaction.to_json['notes']).to eq('notes go here')
      expect(report.transaction.to_json['transaction_id']).to eq('1FA254yZ')
    end
  end
end
