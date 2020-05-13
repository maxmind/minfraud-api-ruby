require 'spec_helper'

describe Minfraud::Assessments do
  let(:resolver)      { double(::Minfraud::Resolver) }
  subject             { described_class.new({}, resolver) }

  before { allow(resolver).to receive(:assign) }

  %w(account billing credit_card custom_inputs device email event order payment shipping shopping_cart).each do |attribute|
    it "responds_to #{attribute}" do
      expect(subject).to respond_to(attribute)
    end
  end

  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }

    it 'calls resolver for components assignment' do
      expect(resolver).to have_received(:assign).with(subject, {})
    end
  end


  describe '#score, #insights, #factors' do
    let(:request)       { double(::Minfraud::HTTPService::Request) }
    let(:raw_response)  { double() }
    let(:error_handler) { ::Minfraud::ErrorHandler }
    let(:response)      { ::Minfraud::HTTPService::Response }

    before(:each) do
      allow_any_instance_of(described_class).to receive(:request) { request }
      allow(error_handler).to receive(:inspect)
      allow(raw_response).to receive_messages(status: 200, body: {}, headers: {})
      allow(request).to receive(:perform) { raw_response }
    end

    after(:each)  { subject.score }

    it 'calls request#perform method' do
      expect(request).to receive(:perform)
    end

    it 'creates response subject from raw response' do
      expect(response).to receive(:new).with(
        endpoint: :score,
        locales: ['en'],
        status:  raw_response.status,
        body:    raw_response.body,
        headers: raw_response.headers
      )
    end

    it 'calls error handler for response inspection' do
      expect(error_handler).to receive(:inspect)
    end
  end
end
