# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::ShoppingCart do
  describe '#initialize' do
    context 'with no provided params' do
      subject(:empty_cart) { described_class.new }

      it 'assigns a default value to the items variable' do
        expect(empty_cart.items).to be_an_instance_of Array
        expect(empty_cart.items).to be_empty
      end
    end

    context 'with provided params' do
      let(:instance_with_hash) { described_class.new([{}]) }
      let(:instance_with_item) { described_class.new([item]) }
      let(:item)               { Minfraud::Components::ShoppingCartItem.new }

      it 'works with array of hashes' do
        expect(instance_with_hash.items).to all(be_a Minfraud::Components::ShoppingCartItem)
      end

      it 'works with array of Minfraud::Components::ShoppingCartItem instances' do
        expect(instance_with_item.items).to all(be_a Minfraud::Components::ShoppingCartItem)
        expect(instance_with_item.items).to eq [item]
      end
    end
  end

  describe '#to_json' do
    context 'with no provided params' do
      subject(:empty_cart) { described_class.new }

      it 'has to be an empty' do
        expect(empty_cart.to_json).to be_empty
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
        described_class.new(
          [
            {
              quantity: -1,
            },
          ],
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
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
