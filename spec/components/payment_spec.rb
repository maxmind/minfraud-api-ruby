# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Payment do
  describe '#initialize' do
    context 'with an invalid processor' do
      it 'raises an exception' do
        expect do
          described_class.new({ processor: :invalid_processor })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end

    context 'with an invalid method' do
      it 'raises an exception' do
        expect do
          described_class.new({ method: :invalid_method })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        processor:      :stripe,
        method:         :card,
        was_authorized: true,
        decline_code:   'insufficient_funds',
      )
    end

    it 'accepts bank_debit as a valid method' do
      described_class.new(
        method: :bank_debit,
      )
    end

    it 'accepts digital_wallet as a valid method' do
      described_class.new(
        method: :digital_wallet,
      )
    end

    it 'accepts buy_now_pay_later as a valid method' do
      described_class.new(
        method: :buy_now_pay_later,
      )
    end
  end
end
