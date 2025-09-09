# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

describe Minfraud::Assessments do
  it 'makes a successful HTTP request' do
    stub_request(:post, /score/).with(
      body:    '{"device":{"ip_address":"1.2.3.4"}}',
      headers: {
        'Authorization' => 'Basic MTE6bXlfbGljZW5zZV9rZXk=',
      },
    ).to_return(
      body:    '{"risk_score":42.1}',
      headers: {
        'Content-Type' => 'application/vnd.maxmind.com-minfraud-score+json; charset=UTF-8; version=2.0',
      },
      status:  200,
    )

    Minfraud.configure do |c|
      c.account_id        = 11
      c.license_key       = 'my_license_key'
      c.enable_validation = true
    end

    assessment = described_class.new(
      device: {
        ip_address: '1.2.3.4',
      },
    )

    score_model = assessment.score.body

    expect(score_model.risk_score).to eq 42.1
  end

  it 'makes an HTTP request resulting in an HTTP 401' do
    stub_request(:post, /score/).with(
      body:    '{"device":{"ip_address":"1.2.3.4"}}',
    ).to_return(
      body:    '{"code":"ACCOUNT_ID_REQUIRED","error":"You have not supplied a MaxMind account ID in the Authorization header."}',
      headers: {
        'Content-Type' => 'application/vnd.maxmind.com-error+json; charset=UTF-8; version=2.0',
      },
      status:  401,
    )

    Minfraud.configure do |c|
      c.account_id        = 11
      c.license_key       = 'my_license_key'
      c.enable_validation = false
    end

    assessment = described_class.new(
      device: {
        ip_address: '1.2.3.4',
      },
    )

    expect { assessment.score }.to raise_error(Minfraud::AuthorizationError)
  end
end

describe Minfraud::Report do
  it 'makes a successful HTTP request' do
    stub_request(:post, /report/).with(
      body:    '{"ip_address":"1.2.3.4"}',
      headers: {
        'Authorization' => 'Basic MTE6bXlfbGljZW5zZV9rZXk=',
      },
    ).to_return(
      status: 204,
    )

    Minfraud.configure do |c|
      c.account_id        = 11
      c.license_key       = 'my_license_key'
      c.enable_validation = true
    end

    txn      = Minfraud::Components::Report::Transaction.new(
      ip_address: '1.2.3.4',
    )
    reporter = described_class.new(transaction: txn)

    expect(reporter.report_transaction).to be_nil
  end

  it 'makes an HTTP request resulting in an HTTP 401' do
    stub_request(:post, /report/).with(
      body:    '{"ip_address":"1.2.3.4"}',
    ).to_return(
      body:    '{"code":"ACCOUNT_ID_REQUIRED","error":"You have not supplied a MaxMind account ID in the Authorization header."}',
      headers: {
        'Content-Type' => 'application/vnd.maxmind.com-error+json; charset=UTF-8; version=2.0',
      },
      status:  401,
    )

    Minfraud.configure do |c|
      c.account_id        = 11
      c.license_key       = 'my_license_key'
      c.enable_validation = false
    end

    txn      = Minfraud::Components::Report::Transaction.new(
      ip_address: '1.2.3.4',
    )
    reporter = described_class.new(transaction: txn)

    expect { reporter.report_transaction }.to raise_error(Minfraud::AuthorizationError)
  end
end
