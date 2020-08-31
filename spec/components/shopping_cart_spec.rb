# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::ShoppingCart do
  describe '#initialize' do
    context 'with no provided params' do
      it 'assigns a default value to the items variable' do
        expect(subject.items).to be_an_instance_of Array
        expect(subject.items).to be_empty
      end
    end

    context 'with provided params' do
      let(:instance) { described_class.new([{}]) }

      it 'works with array of hashes' do
        expect(instance.items).to all(be_a Minfraud::Components::ShoppingCartItem)
      end

      let(:item)     { Minfraud::Components::ShoppingCartItem.new }
      let(:instance) { described_class.new([item]) }

      it 'works with array of Minfraud::Components::ShoppingCartItem instances' do
        expect(instance.items).to all(be_a Minfraud::Components::ShoppingCartItem)
        expect(instance.items).to eq [item]
      end
    end
  end

  describe '#to_json' do
    context 'with no provided params' do
      it 'has to be an empty' do
        expect(subject.to_json).to be_empty
      end
    end

    context 'with provided params' do
      let(:expected) do
        [
          { 'category' => 'test@example.com' },
          { 'category' => 'superman@example.com' }
        ]
      end

      it 'returns an array of items converted to json' do
        instance = described_class.new([
                                         { category: 'test@example.com' },
                                         { category: 'superman@example.com' }
                                       ])

        expect(instance.to_json).to eq(expected)
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid quantity' do
      expect do
        Minfraud::Components::ShoppingCart.new(
          [
            {
              quantity: -1,
            },
          ],
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::ShoppingCart.new(
        [
          {
            category: 'foo',
            item_id:  'bar',
            quantity: 10,
            price:    2.50,
          },
        ],
      )
    end
  end
end
