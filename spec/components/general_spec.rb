# frozen_string_literal: true

require 'spec_helper'

Minfraud::Components.constants.each do |klass|
  next if klass == :Report

  describe Minfraud::Components.const_get(klass) do
    describe '#initialize' do
      it { is_expected.to be_an_instance_of described_class }
      it { is_expected.to respond_to :to_json }
    end
  end
end

describe Minfraud::Components::Report::Transaction do
  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }
    it { is_expected.to respond_to :to_json }
  end
end
