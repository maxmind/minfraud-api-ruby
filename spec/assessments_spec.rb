# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Assessments do
  let(:resolver)      { double(Minfraud::Resolver) }
  subject             { described_class.new({}, resolver) }

  before { allow(resolver).to receive(:assign) }

  %w[account billing credit_card custom_inputs device email event order payment shipping shopping_cart].each do |attribute|
    it "responds_to #{attribute}" do
      expect(subject).to respond_to(attribute)
    end
  end

  describe '#initialize' do
    it { is_expected.to be_an_instance_of described_class }

    it 'calls resolver for components assignment' do
      expect(resolver).to have_received(:assign).with(subject, {})
    end
  end

  describe 'request body' do
    it 'passes email address correctly' do
      tests = [
        {
          email:  {
            address: 'test@maxmind.com',
          },
          output: {
            'email' => {
              'address' => 'test@maxmind.com',
              'domain'  => 'maxmind.com',
            },
          },
        },
        {
          email:  {
            address:      'test@maxmind.com',
            hash_address: true,
          },
          output: {
            'email' => {
              'address' => '977577b140bfb7c516e4746204fbdb01',
              'domain'  => 'maxmind.com',
            },
          },
        },
        {
          email:  {
            address:      ' Test+foo@maxmind.com ',
            hash_address: true,
          },
          output: {
            'email' => {
              'address' => '977577b140bfb7c516e4746204fbdb01',
              'domain'  => 'maxmind.com',
            },
          },
        },
      ]

      tests.each do |i|
        assessment = Minfraud::Assessments.new(
          email: i[:email],
        )
        body       = assessment.send :request_body
        expect(body).to eq i[:output]
      end
    end
  end
end
