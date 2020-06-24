# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::HTTPService::Response do
  subject do
    Minfraud::HTTPService::Response.new({
                                          body:     {},
                                          endpoint: :score,
                                        })
  end

  RSpec.configure do |config|
    config.mock_with :rspec do |mocks|
      mocks.allow_message_expectations_on_nil = true
    end
  end

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
