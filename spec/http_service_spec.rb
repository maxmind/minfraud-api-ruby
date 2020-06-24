# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::HTTPService do
  describe '.configuration' do
    it 'has a default server' do
      expect(described_class::DEFAULT_SERVER).not_to be nil
    end

    it 'has a default middleware' do
      expect(described_class::DEFAULT_MIDDLEWARE).not_to be nil
    end

    it 'returns an instance of Hash' do
      expect(described_class.configuration).to be_an_instance_of Hash
    end
  end
end
