# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Account do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid user_id' do
      expect do
        described_class.new(
          user_id: 'x' * 256,
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid username_md5' do
      expect do
        described_class.new(
          username_md5: 'd3b07384d113edec49eaa6238ad5ff0Z',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception if fields are not populated' do
      described_class.new
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        user_id:      10,
        username_md5: 'd3b07384d113edec49eaa6238ad5ff00',
      )
    end
  end
end
