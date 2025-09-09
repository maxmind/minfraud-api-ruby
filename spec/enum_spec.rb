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
  end
end
