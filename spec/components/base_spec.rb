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

      it 'returns json with boolean values kept as booleans' do
        base_component.instance_variable_set(:@yes, true)
        base_component.instance_variable_set(:@no, false)
        expect(base_component.to_json).to eq(
          expected.merge('yes' => true, 'no' => false),
        )
      end
    end
  end

  describe 'boolean inputs' do
    [
      [Minfraud::Components::CreditCard, :was_3d_secure_successful],
      [Minfraud::Components::Order, :has_gift_message],
      [Minfraud::Components::Order, :is_gift],
      [Minfraud::Components::Payment, :was_authorized],
      [Minfraud::Components::CustomInputs, :boolean_input],
    ].product([true, false]).each do |(component, field), value|
      it "sends #{component}##{field} #{value} as a JSON boolean" do
        expect(component.new(field => value).to_json).to eq(field.to_s => value)
      end
    end
  end
end
