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

  it 'sends phone_verification_method as a string' do
    expect(described_class.new(phone_verification_method: :network).to_json).to eq(
      'phone_verification_method' => 'network',
    )
  end

  it_behaves_like 'a component with verification inputs', 'phone_',
                  phone_verification_method: :delivered_code
end
