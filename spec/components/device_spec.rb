# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Device do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid IP' do
      expect do
        Minfraud::Components::Device.new(
          ip_address: 'foo',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid IP (a network)' do
      expect do
        Minfraud::Components::Device.new(
          ip_address: '1.2.3.4/24',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid session age' do
      expect do
        Minfraud::Components::Device.new(
          session_age: -1,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid session age (too big)' do
      expect do
        Minfraud::Components::Device.new(
          session_age: 1e13,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::Device.new(
        ip_address:  '1.2.3.4',
        session_age: 10,
      )
    end

    it 'does not raise an exception for valid values (IPv6)' do
      Minfraud::Components::Device.new(
        ip_address:  'dead::ffff',
        session_age: 100,
      )
    end
  end
end
