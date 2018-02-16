require 'spec_helper'

describe Minfraud::Components::CustomInputs do
  describe '#initialize' do
    it 'sets the params as instance variables' do
      params = { some_key: 'some value' }
      subject = described_class.new(params)
      expect(subject.instance_variable_get(:@some_key)).to eql(params[:some_key])
    end
  end
end
