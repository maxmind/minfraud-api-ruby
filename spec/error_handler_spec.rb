require 'spec_helper'

describe Minfraud::ErrorHandler do
  describe '.inspect' do
    let(:response) { Object.new }

    it 'returns a response if status is 200' do
      allow(response).to receive(:status) { 200 }
      expect(described_class.inspect(response)).to eq response
    end

    it 'raises an error if status is not 200 and code is matched' do
      allow(response).to receive(:status) { 400 }
      allow(response).to receive(:code) { :IP_ADDRESS_INVALID }

      expect { described_class.inspect(response) }.to raise_error(Minfraud::ClientError)
    end

    it 'raises ServerError if code is not matched' do
      allow(response).to receive(:code) { :DUMMY }
      allow(response).to receive(:status) { 503 }

      expect { described_class.inspect(response) }.to raise_error(Minfraud::ServerError)
    end
  end
end
