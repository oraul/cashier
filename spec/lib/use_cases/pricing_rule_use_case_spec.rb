# frozen_string_literal: true

RSpec.describe PricingRuleUseCase do
  subject(:pricing_rules) { described_class }

  describe '.call' do
    subject(:call) { described_class.call(product_repository:) }

    before { call }

    let(:product_repository) { spy(ProductRepository, all: products) }

    let(:products) do
      [
        instance_spy(ProductEntity, code: 'CF1'),
        instance_spy(ProductEntity, code: 'GR1'),
        instance_spy(ProductEntity, code: 'SR1'),
        instance_spy(ProductEntity, code: 'UNKNOWN')
      ]
    end

    it 'is expected to set rule CF1 on coffee' do
      expect(products[0]).to have_received(:rule=).with(pricing_rules::RULES['CF1'])
    end

    it 'is expected to set rule GR1 on green tea' do
      expect(products[1]).to have_received(:rule=).with(pricing_rules::RULES['GR1'])
    end

    it 'is expected to set rule SR1 on strawberries' do
      expect(products[2]).to have_received(:rule=).with(pricing_rules::RULES['SR1'])
    end

    it 'is expected to not set rule on unknown' do
      expect(products[3]).to have_received(:rule=).with(pricing_rules::DEFAULT_RULE)
    end
  end

  describe 'constant RULES' do
    subject(:rules) { pricing_rules::RULES }

    it { expect(rules.keys).to match_array %w[GR1 SR1 CF1] }
  end

  describe 'constant DEFAULT_RULE' do
    subject(:default_rules) { pricing_rules::DEFAULT_RULE }

    it { is_expected.to be_a(Proc) }
  end

  describe 'Default rule' do
    subject(:rule) { pricing_rules::DEFAULT_RULE.call(total, 1000) }

    context 'when total is 0' do
      let(:total) { 0 }

      it { is_expected.to eq 0 }
    end

    context 'when total is 1' do
      let(:total) { 1 }

      it { is_expected.to eq 1000 }
    end

    context 'when total is 2' do
      let(:total) { 2 }

      it { is_expected.to eq 2000 }
    end

    context 'when total is 3' do
      let(:total) { 3 }

      it { is_expected.to eq 3000 }
    end
  end

  describe 'GR1 rule' do
    subject(:rule) { pricing_rules::RULES['GR1'].call(total, 1000) }

    context 'when total is 0' do
      let(:total) { 0 }

      it { is_expected.to eq 0 }
    end

    context 'when total is 2' do
      let(:total) { 2 }

      it { is_expected.to eq 1000 }
    end

    context 'when total is 3' do
      let(:total) { 3 }

      it { is_expected.to eq 2000 }
    end

    context 'when total is 4' do
      let(:total) { 4 }

      it { is_expected.to eq 2000 }
    end

    context 'when total is 5' do
      let(:total) { 5 }

      it { is_expected.to eq 3000 }
    end
  end

  describe 'SR1 rule' do
    subject(:rule) { pricing_rules::RULES['SR1'].call(total, 1000) }

    context 'when total is 0' do
      let(:total) { 0 }

      it { is_expected.to eq 0 }
    end

    context 'when total is 2' do
      let(:total) { 2 }

      it { is_expected.to eq 2000 }
    end

    context 'when total is 3' do
      let(:total) { 3 }

      it { is_expected.to eq 1350 }
    end
  end

  describe 'CF1 rule' do
    subject(:rule) { pricing_rules::RULES['CF1'].call(total, 1000) }

    context 'when total is 0' do
      let(:total) { 0 }

      it { is_expected.to eq 0 }
    end

    context 'when total is 2' do
      let(:total) { 2 }

      it { is_expected.to eq 2000 }
    end

    context 'when total is 3' do
      let(:total) { 3 }

      it { is_expected.to eq 2000 }
    end
  end
end
