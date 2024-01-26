# frozen_string_literal: true

require 'spec_helper'

describe Minfraud::Components::Email do
  describe 'validation' do
    before do
      Minfraud.configure { |c| c.enable_validation = 1 }
    end

    it 'raises an exception for an invalid email address' do
      expect do
        Minfraud::Components::Email.new(
          address: 'foo',
        )
      end.to raise_exception(Minfraud::InvalidInputError)
    end

    it 'does not raise an exception for valid values' do
      Minfraud::Components::Email.new(
        address: 'wstorey@maxmind.com',
      )
    end

    it 'does not raise an exception for valid values (address is md5)' do
      Minfraud::Components::Email.new(
        address: 'd3b07384d113edec49eaa6238ad5ff00',
      )
    end
  end

  describe 'cleaning and hashing' do
    it 'cleans domains correctly' do
      tests = [
        { input: '', output: '' },
        { input: '.', output: '' },
        { input: 'gmail.com.', output: 'gmail.com' },
        { input: 'Bücher.ch', output: 'xn--bcher-kva.ch' },
        { input: 'gmaiøl.com', output: 'xn--gmail-yua.com' },
        { input: ' haswhitespace.com  ', output: 'haswhitespace.com' },
        { input: 'gamil.com', output: 'gmail.com' },
      ]

      tests.each do |i|
        email  = Minfraud::Components::Email.new
        output = email.send :clean_domain, i[:input]
        expect(output).to eq i[:output]
      end
    end

    it 'cleans email addresses correctly' do
      tests = [
        { input: '', output: nil },
        { input: 'fasfs', output: nil },
        { input: 'test@gmail', output: 'test@gmail' },
        { input: 'e4d909c290d0fb1ca068ffaddf22cbd0', output: nil },
        { input: 'Test@maxmind', output: 'test@maxmind' },
        { input: 'Test@maxmind.com', output: 'test@maxmind.com' },
        { input: 'Test+007@maxmind.com', output: 'test@maxmind.com' },
        { input: 'Test+007+008@maxmind.com', output: 'test@maxmind.com' },
        { input: 'Test+@maxmind.com', output: 'test@maxmind.com' },
        { input: '+@maxmind.com', output: '+@maxmind.com' },
        { input: '  Test@maxmind.com', output: 'test@maxmind.com' },
        {
          input:  'Test@maxmind.com|abc124472372',
          output: 'test@maxmind.com|abc124472372',
        },
        { input: 'Test+foo@yahoo.com', output: 'test+foo@yahoo.com' },
        { input: 'Test-foo@yahoo.com', output: 'test@yahoo.com' },
        { input: 'Test-foo-foo2@yahoo.com', output: 'test@yahoo.com' },
        { input: 'Test-foo@gmail.com', output: 'test-foo@gmail.com' },
        { input: 'gamil.com@gamil.com', output: 'gamilcom@gmail.com' },
        { input: 'Test+alias@bücher.com', output: 'test@xn--bcher-kva.com' },
        { input: 'foo@googlemail.com', output: 'foo@gmail.com' },
        { input: 'foo.bar@gmail.com', output: 'foobar@gmail.com' },
      ]

      tests.each do |i|
        email  = Minfraud::Components::Email.new
        output = email.send :clean_email_address, i[:input]
        expect(output).to eq i[:output]
      end
    end

    it 'hashes addresses correctly' do
      tests = [
        {
          input:  'Test@maxmind.com',
          output: '977577b140bfb7c516e4746204fbdb01',
        },
        {
          input:  '  Test@maxmind.com',
          output: '977577b140bfb7c516e4746204fbdb01',
        },
        {
          input:  'Test+alias@maxmind.com',
          output: '977577b140bfb7c516e4746204fbdb01',
        },
      ]

      tests.each do |i|
        email  = Minfraud::Components::Email.new
        output = email.send :hash_email_address, i[:input]
        expect(output).to eq i[:output]
      end
    end
  end
end
