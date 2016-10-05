require 'spec_helper'

describe Minfraud::Components::ShoppingCart do
  let(:instance) { described_class.new }

  describe '#initialize' do
    context 'with no provided params' do
      it '@items is an instance of Array' do
        expect(instance.items).to be_an_instance_of Array
      end

      it '@items is an empty array' do
        expect(instance.items).to eq []
      end
    end

    context 'with provided params' do
      it 'works with array of hashes' do
        instance = described_class.new([{}])
        expect(instance.items).to all(be_a Minfraud::Components::ShoppingCartItem)
      end

      it 'works with array of Minfraud::Components::ShoppingCartItem instances' do
        expected = [Minfraud::Components::ShoppingCartItem.new({})]
        instance = described_class.new(expected)

        expect(instance.items).to all(be_a Minfraud::Components::ShoppingCartItem)
        expect(instance.items).to eq expected
      end
    end
  end

  describe '#to_json' do
    context 'with no provided params' do
      it 'returns an empty array' do
        expect(instance.to_json).to eq []
      end
    end

    context 'with provided params' do
      it 'returns an array of items converted to json' do
        expected = [
          { 'category' => 'test@example.com' },
          { 'category' => 'superman@example.com' }
        ]

        instance = described_class.new([
          { category: 'test@example.com' },
          { category: 'superman@example.com' }
        ])

        expect(instance.to_json).to eq(expected)
      end
    end
  end
end
