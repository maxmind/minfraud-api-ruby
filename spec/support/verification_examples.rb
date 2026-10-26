# frozen_string_literal: true

# The prefix is the text before verification_time and
# was_verification_successful in the field names, such as 'phone_'.
RSpec.shared_examples 'a component with verification inputs' do |prefix|
  let(:time_field)       { :"#{prefix}verification_time" }
  let(:successful_field) { :"#{prefix}was_verification_successful" }

  [true, false].each do |successful|
    it "sends #{prefix}was_verification_successful #{successful} as a JSON boolean" do
      component = described_class.new(
        time_field       => '2026-10-01T14:30:00Z',
        successful_field => successful,
      )
      expect(component.to_json).to eq(
        time_field.to_s       => '2026-10-01T14:30:00Z',
        successful_field.to_s => successful,
      )
    end
  end

  context 'with verification validation' do
    around do |example|
      previous = Minfraud.enable_validation

      Minfraud.configure { |c| c.enable_validation = 1 }
      example.run
    ensure
      Minfraud.configure { |c| c.enable_validation = previous }
    end

    it "raises an exception for an invalid #{prefix}verification_time" do
      expect do
        described_class.new(time_field => '2026-10-01 14:30:00')
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it "raises an exception for a boolean #{prefix}verification_time" do
      expect do
        described_class.new(time_field => true)
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it "raises an exception for an invalid #{prefix}was_verification_successful" do
      expect do
        described_class.new(successful_field => 'true')
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it "raises an exception for a non-boolean #{prefix}was_verification_successful" do
      expect do
        described_class.new(successful_field => 1)
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid verification values' do
      described_class.new(
        time_field       => '2026-10-01T14:30:00Z',
        successful_field => false,
      )
    end
  end
end
