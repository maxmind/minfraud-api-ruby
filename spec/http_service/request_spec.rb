require 'spec_helper'

describe Minfraud::HTTPService::Request do
  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }
  end

  describe '#perform' do
    let(:adapter)  { double(Faraday.new) }
    let(:expected) { { verb: :post, endpoint: 'dummy', body: {} } }

    before(:each)  { allow_any_instance_of(described_class).to receive(:adapter) { adapter } }

    it 'calls a method on adapter with passed params' do
      expect(adapter).to receive(:send).with(*expected.values)
      subject.perform(expected)
    end
  end
end
