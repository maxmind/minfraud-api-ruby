# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Order do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid has_gift_message' do
      expect do
        described_class.new(
          has_gift_message: 1,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid uri' do
      expect do
        described_class.new(
          referrer_uri: 'foo',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        has_gift_message: true,
        referrer_uri:     'https://www.maxmind.com',
      )
    end
  end
end
