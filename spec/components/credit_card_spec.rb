# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::CreditCard do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid issuer_id_number' do
      expect do
        Minfraud::Components::CreditCard.new(
          issuer_id_number: '5',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid last_4_digits' do
      expect do
        Minfraud::Components::CreditCard.new(
          last_4_digits: '6',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid token' do
      expect do
        Minfraud::Components::CreditCard.new(
          token: '☃️',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid token (all digits)' do
      expect do
        Minfraud::Components::CreditCard.new(
          token: '123',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::CreditCard.new(
        issuer_id_number: '123456',
        last_4_digits:    '1234',
        token:            'abcd',
      )
    end

    it 'does not raise an exception for valid values (token is all digits)' do
      Minfraud::Components::CreditCard.new(
        issuer_id_number: '123456',
        last_4_digits:    '1234',
        token:            '1' * 20,
      )
    end
  end
end
