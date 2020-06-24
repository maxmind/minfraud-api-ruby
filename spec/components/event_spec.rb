# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Event do
  describe '#initialize' do
    context 'with an invalid type' do
      it 'raises an exception' do
        expect do
          described_class.new({ type: :nonsense })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end
  end
end
