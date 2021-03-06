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
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid time' do
      expect do
        Minfraud::Components::Event.new(
          time: 'August 28, 2020',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::Event.new(
        time: '2020-08-28T14:00:00Z',
      )
    end
  end
end
