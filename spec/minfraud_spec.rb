# frozen_string_literal: true

require 'spec_helper'

describe Minfraud do
  it 'has a version' do
    expect(Minfraud::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'yields Minfraud after execution' do
      expect { |b| Minfraud.configure(&b) }.to yield_with_args(Minfraud)
    end

    it 'sets account_id and license key' do
      Minfraud.configure do |c|
        c.account_id  = 123
        c.license_key = 'dummy'
      end

      expect(Minfraud.account_id).to eq 123
      expect(Minfraud.license_key).to eq 'dummy'
    end
  end
end
