# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::ErrorHandler do
  describe '.examine' do
    let(:response) { Object.new }

    it 'returns a response if status is 200' do
      allow(response).to receive(:status).and_return(200)
      expect(described_class.examine(response)).to eq response
    end

    it 'raises an error if status is not 200 and code is matched' do
      allow(response).to receive_messages(status: 400, code: :JSON_INVALID)

      expect { described_class.examine(response) }.to raise_error(Minfraud::ClientError)
    end

    it 'raises ServerError if code is not matched' do
      allow(response).to receive_messages(code: :DUMMY, status: 503)

      expect { described_class.examine(response) }.to raise_error(Minfraud::ServerError)
    end
  end
end
