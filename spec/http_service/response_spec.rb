require 'spec_helper'

describe Minfraud::HTTPService::Response do
  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }
  end

  describe '#code' do
    it 'is nil if body has no code' do
      expect(subject.code).to be nil
    end

    it 'returns a response code' do
      allow(subject.body).to receive(:code) { :example }
      expect(subject.code).to eq :example
    end
  end
end
