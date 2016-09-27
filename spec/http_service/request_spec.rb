require 'spec_helper'

describe Minfraud::HTTPService::Request do
  let(:instance) { described_class.new({}) }

  describe '#initialize' do
    it "returns an instance of #{described_class}" do
      expect(instance).to be_an_instance_of described_class
    end
  end

  describe '#perform' do
    let(:adapter) { double(Faraday.new) }
    before(:each) { allow_any_instance_of(described_class).to receive(:adapter) { adapter } }

    it 'calls a method on adapter with passed params' do
      expected = { verb: :post, endpoint: 'dummy', body: {} }
      expect(adapter).to receive(:send).with(*expected.values)
      instance.perform(expected)
    end
  end
end
