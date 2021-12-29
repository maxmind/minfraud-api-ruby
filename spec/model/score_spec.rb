# frozen_string_literal: true

require 'json'
require 'spec_helper'

describe Minfraud::Model::Score do
  describe '#initialize' do
    it 'creates a fully populated object' do
      buf    = File.read('spec/fixtures/files/score-response1.json')
      record = JSON.parse(buf)

      score = Minfraud::Model::Score.new(record, ['en'])

      expect(score.disposition.action).to eq 'reject'
      expect(score.disposition.reason).to eq 'custom_rule'
      expect(score.disposition.rule_label).to eq 'custom rule label'
      expect(score.funds_remaining).to eq 10.00
      expect(score.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'
      expect(score.ip_address.risk).to eq 99
      expect(score.queries_remaining).to eq 1_000
      expect(score.risk_score).to eq 0.01

      expect(score.warnings[0].code).to eq 'INPUT_INVALID'
      expect(score.warnings[0].warning).to eq 'Encountered value at /account/user_id that does meet the required constraints'
      expect(score.warnings[0].input_pointer).to eq '/account/user_id'

      expect(score.warnings[1].code).to eq 'INPUT_INVALID'
      expect(score.warnings[1].warning).to eq 'Encountered value at /account/username_md5 that does meet the required constraints'
      expect(score.warnings[1].input_pointer).to eq '/account/username_md5'
    end

    it 'creates a minimally populated object' do
      buf    = File.read('spec/fixtures/files/score-response2.json')
      record = JSON.parse(buf)

      score = Minfraud::Model::Score.new(record, ['en'])

      expect(score.disposition.action).to eq nil
      expect(score.disposition.reason).to eq nil
      expect(score.disposition.rule_label).to eq nil
      expect(score.funds_remaining).to eq 10.00
      expect(score.id).to eq '27d26476-e2bc-11e4-92b8-962e705b4af5'
      expect(score.ip_address.risk).to eq 99
      expect(score.queries_remaining).to eq 1_000
      expect(score.risk_score).to eq 0.01
      expect(score.warnings.length).to eq 0
    end
  end
end
