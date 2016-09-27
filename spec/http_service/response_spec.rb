require 'spec_helper'

describe Minfraud::HTTPService::Response do
  let(:instance) { described_class.new({}) }

  describe '#initialize' do
    it "returns an instance of #{described_class}" do
      expect(instance).to be_an_instance_of described_class
    end
  end

  describe '#code' do
    it 'is nil if body has no code' do
      expect(instance.code).to be nil
    end

    it 'returns a response code' do
      allow(instance.body).to receive(:code) { :DUMMY }

      expect(instance.code).to eq :DUMMY
    end
  end
end
