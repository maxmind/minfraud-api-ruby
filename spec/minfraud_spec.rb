require 'spec_helper'

describe Minfraud do
  it 'has a version' do
    expect(Minfraud::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'yields Minfraud after execution' do
      expect { |b| Minfraud.configure(&b) }.to yield_with_args(Minfraud)
    end

    it 'sets user_id and license key' do
      Minfraud.configure do |c|
        c.user_id     = 'dummy'
        c.license_key = 'dummy'
      end

      expect(Minfraud.user_id).to eq 'dummy'
      expect(Minfraud.license_key).to eq 'dummy'
    end
  end

  describe '.configuration' do
    it 'returns an instance of Hash' do
      expect(Minfraud.configuration).to be_an_instance_of Hash
    end
  end
end
