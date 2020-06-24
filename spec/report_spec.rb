# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Report do
  subject { described_class.new }

  %w[transaction].each do |attribute|
    it "responds_to #{attribute}" do
      expect(subject).to respond_to(attribute)
    end
  end

  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }
  end

  describe '#report_transaction' do
    let(:request)       { double(::Minfraud::HTTPService::Request) }
    let(:raw_response) { double }
    let(:error_handler) { ::Minfraud::ErrorHandler }

    before(:each) do
      allow_any_instance_of(described_class).to receive(:request) { request }
      allow(error_handler).to receive(:examine)
      allow(raw_response).to receive_messages(status: 204, body: {}, headers: {})
      allow(request).to receive(:perform) { raw_response }
    end

    after(:each) { subject.report_transaction }

    it 'calls request#perform method' do
      expect(request).to receive(:perform)
    end

    it 'calls error handler for response examination' do
      expect(error_handler).to receive(:examine)
    end
  end
end

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
