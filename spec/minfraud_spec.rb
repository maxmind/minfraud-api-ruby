# frozen_string_literal: true

require 'spec_helper'

describe Minfraud do
  it 'has a version' do
    expect(Minfraud::VERSION).not_to be_nil
  end

  describe '.configure' do
    it 'yields Minfraud after execution' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(described_class)
    end

    it 'sets account_id and license key' do
      described_class.configure do |c|
        c.account_id  = 123
        c.license_key = 'dummy'
      end

      expect(described_class.account_id).to eq 123
      expect(described_class.license_key).to eq 'dummy'
    end
  end
end
