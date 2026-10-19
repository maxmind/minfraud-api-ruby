# frozen_string_literal: true

RSpec.shared_examples 'an addressable component' do
  it 'includes phone_verification_method in the mapping' do
    expect(described_class.mapping).to include(phone_verification_method: %i[delivered_code network other])
  end

  it 'accepts each phone_verification_method value' do
    %i[delivered_code network other].each do |method|
      expect(described_class.new(phone_verification_method: method).phone_verification_method).to eq(method)
    end
  end

  it 'raises an exception for an invalid phone_verification_method' do
    expect do
      described_class.new(phone_verification_method: :sms)
    end.to raise_exception(Minfraud::NotEnumValueError)
  end

  [true, false].each do |successful|
    it "sends phone_was_verification_successful #{successful} as a JSON boolean" do
      component = described_class.new(
        phone_verification_method:         'network',
        phone_verification_time:           '2026-10-01T14:30:00Z',
        phone_was_verification_successful: successful,
      )
      expect(component.to_json).to eq(
        'phone_verification_method'         => 'network',
        'phone_verification_time'           => '2026-10-01T14:30:00Z',
        'phone_was_verification_successful' => successful,
      )
    end
  end

  context 'with validation' do
    around do |example|
      previous = Minfraud.enable_validation

      Minfraud.configure { |c| c.enable_validation = 1 }
      example.run
    ensure
      Minfraud.configure { |c| c.enable_validation = previous }
    end

    it 'raises an exception for an invalid phone_was_verification_successful' do
      expect do
        described_class.new(
          phone_was_verification_successful: 'true',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'raises an exception for an invalid phone_verification_time' do
      expect do
        described_class.new(
          phone_verification_time: '2026-10-01 14:30:00',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid phone verification values' do
      described_class.new(
        phone_verification_method:         :delivered_code,
        phone_verification_time:           '2026-10-01T14:30:00Z',
        phone_was_verification_successful: false,
      )
    end
  end
end
