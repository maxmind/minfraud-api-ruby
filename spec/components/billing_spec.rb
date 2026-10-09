# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Billing do
  describe '#initialize' do
    it 'accepts each phone_verification_method value' do
      %i[delivered_code network other].each do |method|
        expect(described_class.new(phone_verification_method: method).phone_verification_method).to eq(method)
      end
    end

    it 'raises an exception for an invalid phone_verification_method' do
      expect do
        described_class.new(phone_verification_method: :sms)
      end.to raise_exception(Minfraud::NotEnumValueError)
    end
  end

  describe '#to_json' do
    [true, false].each do |successful|
      it "sends phone_was_verification_successful #{successful} as a JSON boolean" do
        billing = described_class.new(
          phone_verification_method:         'network',
          phone_verification_time:           '2026-10-01T14:30:00Z',
          phone_was_verification_successful: successful,
        )
        expect(billing.to_json).to eq(
          'phone_verification_method'         => 'network',
          'phone_verification_time'           => '2026-10-01T14:30:00Z',
          'phone_was_verification_successful' => successful,
        )
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid region' do
      expect do
        described_class.new(
          region: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid country' do
      expect do
        described_class.new(
          country: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid phone_country_code' do
      expect do
        described_class.new(
          phone_country_code: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid phone_was_verification_successful' do
      expect do
        described_class.new(
          phone_was_verification_successful: 'true',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid phone_verification_time' do
      expect do
        described_class.new(
          phone_verification_time: '2026-10-01 14:30:00',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        region:                            'BC',
        country:                           'CA',
        phone_country_code:                '1',
        phone_verification_method:         :delivered_code,
        phone_verification_time:           '2026-10-01T14:30:00Z',
        phone_was_verification_successful: false,
      )
    end
  end
end
