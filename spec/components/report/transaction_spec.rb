# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Report::Transaction do
  describe '#initialize' do
    before do
      Minfraud.configure { |c| c.enable_validation = false }
    end

    context 'with an invalid type' do
      it 'raises an exception' do
        expect do
          described_class.new(tag: 'foo')
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end

    context 'with all valid tags' do
      values = %i[chargeback not_fraud spam_or_abuse suspected_fraud]
      values.each do |val|
        it "accepts #{val} as a valid tag" do
          result = described_class.new(tag: val)
          expect(result.tag).to eq(val)
        end
      end
    end

    context 'with all possible params' do
      it 'does not raise an exception' do
        report = described_class.new(
          ip_address:      '1.2.3.4',
          tag:             :suspected_fraud,
          chargeback_code: 'foo',
          maxmind_id:      '12345678',
          minfraud_id:     '58fa38d8-4b87-458b-a22b-f00eda1aa20d',
          notes:           'notes go here',
          transaction_id:  '1FA254yZ'
        )

        expect(report.ip_address).to eq '1.2.3.4'
        expect(report.tag).to eq :suspected_fraud
        expect(report.chargeback_code).to eq 'foo'
        expect(report.maxmind_id).to eq '12345678'
        expect(report.minfraud_id).to eq '58fa38d8-4b87-458b-a22b-f00eda1aa20d'
        expect(report.notes).to eq 'notes go here'
        expect(report.transaction_id).to eq '1FA254yZ'
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = true }
    end

    context 'when missing required identifier field' do
      it 'raises an exception' do
        expect do
          described_class.new(tag: :suspected_fraud)
        end.to raise_exception(ArgumentError)
      end
    end

    context 'with tag + ip_address' do
      it 'does not raise an exception' do
        report = described_class.new(
          ip_address: '1.2.3.4',
          tag:        :suspected_fraud
        )

        expect(report.ip_address).to eq '1.2.3.4'
        expect(report.tag).to eq :suspected_fraud
      end
    end

    context 'with tag + maxmind_id' do
      it 'does not raise an exception' do
        report = described_class.new(
          tag:        :suspected_fraud,
          maxmind_id: '12345678'
        )

        expect(report.tag).to eq :suspected_fraud
        expect(report.maxmind_id).to eq '12345678'
      end
    end

    context 'with tag + minfraud_id' do
      it 'does not raise an exception' do
        report = described_class.new(
          tag:         :suspected_fraud,
          minfraud_id: '58fa38d8-4b87-458b-a22b-f00eda1aa20d'
        )

        expect(report.tag).to eq :suspected_fraud
        expect(report.minfraud_id).to eq '58fa38d8-4b87-458b-a22b-f00eda1aa20d'
      end
    end

    context 'with tag + transaction_id' do
      it 'does not raise an exception' do
        report = described_class.new(
          tag:            :suspected_fraud,
          transaction_id: '1FA254yZ'
        )

        expect(report.tag).to eq :suspected_fraud
        expect(report.transaction_id).to eq '1FA254yZ'
      end
    end
  end
end
