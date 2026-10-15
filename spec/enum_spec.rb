# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Enum do
  let(:klass) do
    Class.new do
      include Minfraud::Enum

      enum_accessor :test, %i[foo bar]
    end
  end

  describe '.mapping' do
    it 'is an instance of Hash' do
      expect(klass.mapping).to be_an_instance_of Hash
    end
  end

  describe '#enum_accessor' do
    let(:instance) { klass.new }

    it 'adds an attribute to mapping' do
      expect(klass.mapping).to include(:test)
    end

    it 'defines #[attribute_name]_values method' do
      expect(klass).to respond_to :test_values
    end

    it 'defines #[attribute_name]_values only on the declaring class' do
      klass
      expect(String).not_to respond_to :test_values
    end

    it 'keeps #[attribute_name]_values when another class declares the same attribute' do
      klass
      Class.new do
        include Minfraud::Enum

        enum_accessor :test, %i[baz]
      end
      expect(klass.test_values).to eq %i[foo bar]
    end

    it 'defines attribute reader' do
      expect(instance).to respond_to :test
    end

    it 'defines attribute setter' do
      expect(instance).to respond_to :test=
    end

    it 'raises NotEnumValueError for unpermitted values' do
      expect { instance.test = :unpermitted_value }.to raise_error Minfraud::NotEnumValueError
    end

    it 'converts string value to symbol' do
      instance.test = 'foo'
      expect(instance.test).to eq :foo
    end

    it 'assigns value if it is permitted' do
      instance.test = :foo
      expect(instance.test).to eq :foo
    end

    it 'assigns a permitted value in a subclass' do
      subinstance      = Class.new(klass).new
      subinstance.test = :foo
      expect(subinstance.test).to eq :foo
    end

    it 'raises NotEnumValueError for unpermitted values in a subclass' do
      expect { Class.new(klass).new.test = :unpermitted_value }.to raise_error Minfraud::NotEnumValueError
    end

    it 'returns the parent values from #[attribute_name]_values in a subclass' do
      expect(Class.new(klass).test_values).to eq %i[foo bar]
    end

    it 'includes parent attributes in the subclass mapping' do
      subclass = Class.new(klass) { enum_accessor :other, %i[baz] }
      expect(subclass.mapping).to eq(test: %i[foo bar], other: %i[baz])
    end
  end
end
