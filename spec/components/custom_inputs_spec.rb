# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::CustomInputs do
  let(:params) { { some_key: 'some value' } }
  subject { described_class.new(params) }

  describe '#initialize' do
    it 'sets the params as instance variables' do
      expect(subject.instance_variable_get(:@some_key)).to eql(params[:some_key])
    end
  end
end
