# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Email do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid email address' do
      expect do
        Minfraud::Components::Email.new(
          address: 'foo',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::Email.new(
        address: 'wstorey@maxmind.com',
      )
    end

    it 'does not raise an exception for valid values (address is md5)' do
      Minfraud::Components::Email.new(
        address: 'd3b07384d113edec49eaa6238ad5ff00',
      )
    end
  end
end
