# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Event do
  describe '#initialize' do
    context 'with an invalid type' do
      it 'raises an exception' do
        expect do
          described_class.new({ type: :nonsense })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end

    context 'with an invalid party' do
      it 'raises an exception' do
        expect do
          described_class.new({ party: :invalid })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid time' do
      expect do
        described_class.new(
          time: 'August 28, 2020',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        time: '2020-08-28T14:00:00Z',
      )
    end

    it 'accepts credit_application as a valid type' do
      described_class.new(
        type: :credit_application,
      )
    end

    it 'accepts fund_transfer as a valid type' do
      described_class.new(
        type: :fund_transfer,
      )
    end

    it 'accepts agent as a valid party' do
      described_class.new(
        party: :agent,
      )
    end

    it 'accepts customer as a valid party' do
      described_class.new(
        party: :customer,
      )
    end
  end
end
