require 'spec_helper'

describe Minfraud::Components::Base do
  let(:instance) { described_class.new }

  describe '#to_json' do
    it 'to be an instance of Hash' do
      expect(instance.to_json).to be_an_instance_of Hash
    end

    context 'with no instance variables' do
      it 'returns an empty hash' do
        expect(instance.to_json).to eq({})
      end
    end

    context 'with instance variables' do
      it 'returns json representation of attributes' do
        expected = { 'dummy' => 'test@example.com' }
        instance.instance_variable_set(:@dummy, 'test@example.com')

        expect(instance.to_json).to eq(expected)
      end

      it 'returns json without nil values' do
        expected = { 'dummy' => 'test@example.com' }
        instance.instance_variable_set(:@dummy, 'test@example.com')
        instance.instance_variable_set(:@nullable, nil)

        expect(instance.to_json).to eq(expected)
      end
    end
  end
end
