# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Resolver do
  let(:context) { Object.new }

  describe '.assign' do
    it 'raises ArgumentError when params are missing' do
      expect { described_class.assign }.to raise_error(ArgumentError)
    end

    it 'raises RequestFormatError with unpermitted params' do
      expect { described_class.assign(context, { dummy: :data }) }.to raise_error(Minfraud::RequestFormatError)
    end

    it 'correctly handles empty params' do
      described_class.assign(context, {})
      expect(context.instance_variables.length).to be 0
    end

    it 'maps hash keys to corresponding components' do
      allow(context).to receive(:account) { ::Minfraud::Components::Account.new }
      allow(context).to receive(:account=)

      described_class.assign(context, { account: {} })

      expect(context).to respond_to(:account)
      expect(context.account).to be_an_instance_of ::Minfraud::Components::Account
    end
  end
end
