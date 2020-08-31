# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::CustomInputs do
  let(:params) { { some_key: 'some value' } }
  subject { described_class.new(params) }

  describe '#initialize' do
    it 'sets the params as instance variables' do
      expect(subject.instance_variable_get(:@some_key)).to eql(params[:some_key])
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid number' do
      expect do
        Minfraud::Components::CustomInputs.new(
          number: 1e13,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid number (negative)' do
      expect do
        Minfraud::Components::CustomInputs.new(
          number: -1e13,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid string' do
      expect do
        Minfraud::Components::CustomInputs.new(
          string: 'f' * 257,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::CustomInputs.new(
        number: 10,
        string: 'foo',
      )
    end
  end
end
