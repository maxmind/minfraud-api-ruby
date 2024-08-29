# frozen_string_literal: true

require 'json'
require 'spec_helper'

describe Minfraud::Model::Factors do
  describe '#initialize' do
    it 'creates a fully populated object' do
      buf    = File.read('spec/fixtures/files/factors-response1.json')
      record = JSON.parse(buf)

      m = Minfraud::Model::Factors.new(record, ['en'])

      expect(m.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'

      expect(m.subscores.avs_result).to eq 0.01
      expect(m.subscores.billing_address).to eq 0.02
      expect(m.subscores.billing_address_distance_to_ip_location).to eq 0.03
      expect(m.subscores.browser).to eq 0.04
      expect(m.subscores.chargeback).to eq 0.05
      expect(m.subscores.country).to eq 0.06
      expect(m.subscores.country_mismatch).to eq 0.07
      expect(m.subscores.cvv_result).to eq 0.08
      expect(m.subscores.device).to eq 0.18
      expect(m.subscores.email_address).to eq 0.09
      expect(m.subscores.email_domain).to eq 0.10
      expect(m.subscores.email_local_part).to eq 0.19
      expect(m.subscores.issuer_id_number).to eq 0.13
      expect(m.subscores.order_amount).to eq 0.14
      expect(m.subscores.phone_number).to eq 0.15
      expect(m.subscores.shipping_address).to eq 0.2
      expect(m.subscores.shipping_address_distance_to_ip_location).to eq 0.16
      expect(m.subscores.time_of_day).to eq 0.17

      expect(m.risk_score_reasons.length).to eq 4
      expect(m.risk_score_reasons[0].multiplier).to eq 45.0
      expect(m.risk_score_reasons[0].reasons.length).to eq 1
      expect(m.risk_score_reasons[0].reasons[0].code).to eq 'ANONYMOUS_IP'
      expect(m.risk_score_reasons[0].reasons[0].reason).to eq 'Risk due to IP being an Anonymous IP'
    end

    it 'checks absence of risk score reasons' do
      buf    = File.read('spec/fixtures/files/factors-response1.json')
      record = JSON.parse(buf)
      record.delete('risk_score_reasons')

      m = Minfraud::Model::Factors.new(record, ['en'])

      expect(m.risk_score_reasons).to eq []
    end
  end
end
