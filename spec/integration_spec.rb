# frozen_string_literal: true

RSpec.describe 'Integration' do
  subject(:total) { checkout.total }

  let(:products) { PricingRuleRepository.all }
  let(:pricing_rules) { PricingRules.apply(products) }
  let(:checkout) { Checkout.new(pricing_rules) }

  before do
    basket.each { |code| checkout.scan(code) }
  end

  context 'when checkout scan GR1,SR1,GR1,GR1,CF1' do
    let(:basket) { %w[GR1 SR1 GR1 GR1 CF1] }

    it { is_expected.to eq '£22.45' }
  end

  context 'when checkout scan GR1,GR1' do
    let(:basket) { %w[GR1 GR1] }

    it { is_expected.to eq '£3.11' }
  end

  context 'when checkout scan SR1,SR1,GR1,SR1' do
    let(:basket) { %w[SR1 SR1 GR1 SR1] }

    it { is_expected.to eq '£16.61' }
  end

  context 'when checkout scan GR1,CF1,SR1,CF1,CF1' do
    let(:basket) { %w[GR1 CF1 SR1 CF1 CF1] }

    it { is_expected.to eq '£30.57' }
  end
end
