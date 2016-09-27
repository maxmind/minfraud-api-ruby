require 'spec_helper'

%w(Account Addressable Billing CreditCard Device Email Event Order Payment Shipping ShoppingCartItem).each do |klass|
  describe Object.const_get("Minfraud::Components::#{klass}") do
    describe '#initialize' do
      let(:instance)   { described_class.new }

      it "creates an instance of #{described_class}" do
        expect(instance).to be_an_instance_of described_class
      end

      context 'with no provided params' do
        it 'attributes are set to nil' do
          instance.instance_variables.each do |attribute|
            expect(instance.instance_variable_get(attribute)).to be nil
          end
        end
      end
    end
  end
end
