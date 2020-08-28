# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Billing do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid region' do
      expect do
        Minfraud::Components::Billing.new(
          region: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid country' do
      expect do
        Minfraud::Components::Billing.new(
          country: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid phone_country_code' do
      expect do
        Minfraud::Components::Billing.new(
          phone_country_code: 'HIHIHI',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::Billing.new(
        region:             'BC',
        country:            'CA',
        phone_country_code: '1',
      )
    end
  end
end
