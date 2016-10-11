require 'spec_helper'

Minfraud::Components.constants.each do |klass|
  describe Minfraud::Components.const_get(klass) do
    describe '#initialize' do
      it { is_expected.to be_an_instance_of described_class }
      it { is_expected.to respond_to :to_json }
    end
  end
end
