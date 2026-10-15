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

    context 'with an invalid party' do
      it 'raises an exception' do
        expect do
          described_class.new({ party: :invalid })
        end.to raise_exception(Minfraud::NotEnumValueError)
      end
    end
  end

  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid time' do
      expect do
        described_class.new(
          time: 'August 28, 2020',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    %w[
      2026-10-01T24:00:00Z
      2026-10-01T14:60:00Z
      2026-10-01T14:30:60Z
      2026-10-01T14:30:00+24:00
      2026-10-01T14:30:00+25:00
      2026-10-01T14:30:00+05:60
      2026-13-01T10:00:00Z
      2026-02-30T10:00:00Z
      2026-02-29T00:00:00Z
      1500-02-29T00:00:00Z
      2026-10-01t14:30:00Z
      2026-10-01T14:30:00z
      2026-1-01T14:30:00Z
    ].each do |time|
      it "raises an exception for time #{time}" do
        expect do
          described_class.new(time:)
        end.to raise_exception(Minfraud::InvalidInputError)
      end
    end

    %W[
      2026-10-01T14:30:00Z
      2026-10-01T14:30:00.123456789Z
      2026-10-01T14:30:00.#{'9' * 120}Z
      2026-10-01T14:30:00+23:59
      2024-02-29T00:00:00Z
      2024-02-29T00:00:00-05:00
    ].each do |time|
      it "accepts time #{time}" do
        expect(described_class.new(time:).time).to eq(time)
      end
    end

    it 'does not raise an exception for valid values' do
      described_class.new(
        time: '2020-08-28T14:00:00Z',
      )
    end

    it 'accepts credit_application as a valid type' do
      described_class.new(
        type: :credit_application,
      )
    end

    it 'accepts fund_transfer as a valid type' do
      described_class.new(
        type: :fund_transfer,
      )
    end

    it 'accepts sim_swap as a valid type' do
      described_class.new(
        type: :sim_swap,
      )
    end

    it 'accepts agent as a valid party' do
      described_class.new(
        party: :agent,
      )
    end

    it 'accepts customer as a valid party' do
      described_class.new(
        party: :customer,
      )
    end
  end
end
