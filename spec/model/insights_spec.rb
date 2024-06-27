# frozen_string_literal: true

require 'json'
require 'spec_helper'

describe Minfraud::Model::Insights do
  describe '#initialize' do
    it 'creates a fully populated object' do
      buf    = File.read('spec/fixtures/files/insights-response1.json')
      record = JSON.parse(buf)

      m = Minfraud::Model::Insights.new(record, ['en'])

      expect(m.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'
      expect(m.risk_score).to eq 0.01
      expect(m.funds_remaining).to eq 10.00
      expect(m.queries_remaining).to eq 1_000

      expect(m.disposition.action).to eq 'reject'
      expect(m.disposition.reason).to eq 'custom_rule'
      expect(m.disposition.rule_label).to eq 'custom rule label'

      expect(m.ip_address.risk).to eq 0.01
      expect(m.ip_address.risk_reasons[0].code).to eq 'ANONYMOUS_IP'
      expect(m.ip_address.risk_reasons[0].reason).to eq 'The IP address belongs to an anonymous network. See /ip_address/traits for more details.'
      expect(m.ip_address.risk_reasons[1].code).to eq 'MINFRAUD_NETWORK_ACTIVITY'
      expect(m.ip_address.risk_reasons[1].reason).to eq 'Suspicious activity has been seen on this IP address across minFraud customers.'

      expect(m.ip_address.city.confidence).to eq 42
      expect(m.ip_address.city.geoname_id).to eq 2_643_743
      expect(m.ip_address.city.names['en']).to eq 'London'

      expect(m.ip_address.continent.code).to eq 'EU'
      expect(m.ip_address.continent.geoname_id).to eq 6_255_148
      expect(m.ip_address.continent.names['en']).to eq 'Europe'

      expect(m.ip_address.country.confidence).to eq 99
      expect(m.ip_address.country.geoname_id).to eq 2_635_167
      expect(m.ip_address.country.in_european_union?).to eq true
      expect(m.ip_address.country.iso_code).to eq 'GB'
      expect(m.ip_address.country.names['en']).to eq 'United Kingdom'

      expect(m.ip_address.location.accuracy_radius).to eq 96
      expect(m.ip_address.location.average_income).to eq 10_000
      expect(m.ip_address.location.latitude).to eq 51.5142
      expect(m.ip_address.location.local_time).to eq '2012-04-13T00:20:50+01:00'
      expect(m.ip_address.location.longitude).to eq(-0.0931)
      expect(m.ip_address.location.metro_code).to eq 12
      expect(m.ip_address.location.population_density).to eq 5
      expect(m.ip_address.location.time_zone).to eq 'Europe/London'

      expect(m.ip_address.postal.code).to eq 'H0H'
      expect(m.ip_address.postal.confidence).to eq 99

      expect(m.ip_address.registered_country.geoname_id).to eq 6_252_001
      expect(m.ip_address.registered_country.in_european_union?).to eq false
      expect(m.ip_address.registered_country.iso_code).to eq 'US'
      expect(m.ip_address.registered_country.names['en']).to eq 'United States'

      expect(m.ip_address.represented_country.geoname_id).to eq 6_252_002
      expect(m.ip_address.represented_country.in_european_union?).to eq false
      expect(m.ip_address.represented_country.iso_code).to eq 'US'
      expect(m.ip_address.represented_country.names['en']).to eq 'United States'
      expect(m.ip_address.represented_country.type).to eq 'military'

      expect(m.ip_address.subdivisions[0].confidence).to eq 42
      expect(m.ip_address.subdivisions[0].geoname_id).to eq 6_269_131
      expect(m.ip_address.subdivisions[0].iso_code).to eq 'ENG'
      expect(m.ip_address.subdivisions[0].names['en']).to eq 'England'

      expect(m.ip_address.traits.autonomous_system_number).to eq 123
      expect(m.ip_address.traits.autonomous_system_organization).to eq 'Foo Inc'
      expect(m.ip_address.traits.connection_type).to eq 'Cable/DSL'
      expect(m.ip_address.traits.domain).to eq 'in-addr.arpa'
      expect(m.ip_address.traits.ip_address).to eq '152.216.7.110'
      expect(m.ip_address.traits.anonymous?).to eq true
      expect(m.ip_address.traits.anonymous_vpn?).to eq true
      expect(m.ip_address.traits.hosting_provider?).to eq true
      expect(m.ip_address.traits.public_proxy?).to eq true
      expect(m.ip_address.traits.residential_proxy?).to eq true
      expect(m.ip_address.traits.is_satellite_provider).to eq true
      expect(m.ip_address.traits.tor_exit_node?).to eq true
      expect(m.ip_address.traits.isp).to eq 'Andrews & Arnold Ltd'
      expect(m.ip_address.traits.mobile_country_code).to eq '310'
      expect(m.ip_address.traits.mobile_network_code).to eq '004'
      expect(m.ip_address.traits.organization).to eq 'STONEHOUSE office network'
      expect(m.ip_address.traits.static_ip_score).to eq 13.5
      expect(m.ip_address.traits.user_count).to eq 5
      expect(m.ip_address.traits.user_type).to eq 'government'

      expect(m.billing_address.is_postal_in_city).to eq false
      expect(m.billing_address.latitude).to eq 41.310571
      expect(m.billing_address.longitude).to eq(-72.922891)
      expect(m.billing_address.distance_to_ip_location).to eq 5_465
      expect(m.billing_address.is_in_ip_country).to eq false

      expect(m.billing_phone.country).to eq 'US'
      expect(m.billing_phone.is_voip).to eq false
      expect(m.billing_phone.network_operator).to eq 'Verizon/1'
      expect(m.billing_phone.number_type).to eq 'fixed'

      expect(m.credit_card.issuer.name).to eq 'Bank of No Hope'
      expect(m.credit_card.issuer.matches_provided_name).to eq true
      expect(m.credit_card.issuer.phone_number).to eq '8003421232'
      expect(m.credit_card.issuer.matches_provided_phone_number).to eq true

      expect(m.credit_card.brand).to eq 'Visa'
      expect(m.credit_card.country).to eq 'US'
      expect(m.credit_card.is_business).to eq true
      expect(m.credit_card.is_issued_in_billing_address_country).to eq true
      expect(m.credit_card.is_prepaid).to eq true
      expect(m.credit_card.is_virtual).to eq true
      expect(m.credit_card.type).to eq 'credit'

      expect(m.device.confidence).to eq 99
      expect(m.device.id).to eq '7835b099-d385-4e5b-969e-7df26181d73b'
      expect(m.device.last_seen).to eq '2016-06-08T14:16:38Z'
      expect(m.device.local_time).to eq '2017-06-08T14:16:38Z'

      expect(m.email.domain.first_seen).to eq '2016-01-03'
      expect(m.email.first_seen).to eq '2017-01-02'
      expect(m.email.is_disposable).to eq true
      expect(m.email.is_free).to eq true
      expect(m.email.is_high_risk).to eq true

      expect(m.shipping_address.distance_to_billing_address).to eq 2_227
      expect(m.shipping_address.distance_to_ip_location).to eq 7_456
      expect(m.shipping_address.is_in_ip_country).to eq false
      expect(m.shipping_address.is_high_risk).to eq false
      expect(m.shipping_address.is_postal_in_city).to eq false
      expect(m.shipping_address.latitude).to eq 35.704729
      expect(m.shipping_address.longitude).to eq(-97.568619)

      expect(m.shipping_phone.country).to eq 'CA'
      expect(m.shipping_phone.is_voip).to eq true
      expect(m.shipping_phone.network_operator).to eq 'Telus Mobility-SVR/2'
      expect(m.shipping_phone.number_type).to eq 'mobile'

      expect(m.warnings[0].code).to eq 'INPUT_INVALID'
      expect(m.warnings[0].warning).to eq 'Encountered value at /account/user_id that does meet the required constraints'
      expect(m.warnings[0].input_pointer).to eq '/account/user_id'

      expect(m.warnings[1].code).to eq 'INPUT_INVALID'
      expect(m.warnings[1].warning).to eq 'Encountered value at /account/username_md5 that does meet the required constraints'
      expect(m.warnings[1].input_pointer).to eq '/account/username_md5'
    end

    it 'creates a populated object missing some fields' do
      buf    = File.read('spec/fixtures/files/insights-response2.json')
      record = JSON.parse(buf)

      m = Minfraud::Model::Insights.new(record, ['en'])

      expect(m.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'

      expect(m.disposition.action).to eq nil
      expect(m.disposition.reason).to eq nil
      expect(m.disposition.rule_label).to eq nil

      expect(m.ip_address.risk).to eq 0.01
      expect(m.ip_address.risk_reasons.length).to eq 0

      expect(m.ip_address.city.confidence).to eq nil
      expect(m.ip_address.city.geoname_id).to eq nil
      expect(m.ip_address.city.names).to eq nil

      expect(m.ip_address.location.accuracy_radius).to eq nil
      expect(m.ip_address.location.average_income).to eq nil
      expect(m.ip_address.location.latitude).to eq nil
      expect(m.ip_address.location.local_time).to eq nil
      expect(m.ip_address.location.longitude).to eq nil
      expect(m.ip_address.location.metro_code).to eq nil
      expect(m.ip_address.location.population_density).to eq nil
      expect(m.ip_address.location.time_zone).to eq nil

      expect(m.ip_address.traits.autonomous_system_number).to eq nil
      expect(m.ip_address.traits.autonomous_system_organization).to eq 'Foo Inc'
      expect(m.ip_address.traits.anonymous?).to eq false
      expect(m.ip_address.traits.connection_type).to eq 'Corporate'
      expect(m.ip_address.traits.residential_proxy?).to eq false
      expect(m.ip_address.traits.is_satellite_provider).to eq false
      expect(m.ip_address.traits.tor_exit_node?).to eq false

      expect(m.billing_address.is_postal_in_city).to eq nil
      expect(m.billing_address.distance_to_ip_location).to eq nil
      expect(m.billing_address.is_in_ip_country).to eq false

      expect(m.credit_card.issuer.name).to eq 'Bank of No Hope'
      expect(m.credit_card.is_business).to eq nil
      expect(m.credit_card.issuer.matches_provided_name).to eq nil

      expect(m.credit_card.brand).to eq nil
      expect(m.credit_card.country).to eq 'US'

      expect(m.device.confidence).to eq nil
      expect(m.device.id).to eq '7835b099-d385-4e5b-969e-7df26181d73b'

      expect(m.email.domain.first_seen).to eq nil
      expect(m.email.first_seen).to eq nil
      expect(m.email.is_disposable).to eq true

      expect(m.shipping_address.distance_to_billing_address).to eq nil
      expect(m.shipping_address.distance_to_ip_location).to eq 7_456
    end

    it 'creates an object when the response lacks many fields' do
      buf    = File.read('spec/fixtures/files/insights-response3.json')
      record = JSON.parse(buf)

      m = Minfraud::Model::Insights.new(record, ['en'])

      expect(m.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'
      expect(m.risk_score).to eq 0.01
      expect(m.funds_remaining).to eq 10.00
      expect(m.queries_remaining).to eq 1_000
    end
  end
end
