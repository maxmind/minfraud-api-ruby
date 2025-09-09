# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Base do
  subject(:base_component) { described_class.new }

  describe '#to_json' do
    it 'has to be an instance of Hash' do
      expect(base_component.to_json).to be_an_instance_of Hash
    end

    context 'with no instance variables' do
      it 'has to be empty' do
        expect(base_component.to_json).to be_empty
      end
    end

    context 'with instance variables' do
      let(:expected) { { 'dummy' => 'test@example' } }

      before { base_component.instance_variable_set(:@dummy, 'test@example') }

      it 'returns json representation of attributes' do
        expect(base_component.to_json).to eq(expected)
      end

      it 'returns json while ignoring nil values' do
        base_component.instance_variable_set(:@null, nil)
        expect(base_component.to_json).to eq(expected)
      end
    end
  end
end
