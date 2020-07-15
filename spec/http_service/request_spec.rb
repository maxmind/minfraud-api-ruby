# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::HTTPService::Request do
  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }
  end
end
