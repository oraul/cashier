# frozen_string_literal: true

RSpec.describe PricingRuleUseCase do
  subject(:pricing_rules) { described_class }

  describe '.call' do
    subject(:call) { described_class.call(product_repository:) }

    before { call }

    let(:product_repository) { class_double(ProductRepository, all: products) }

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

  shared_examples 'calculations and results' do |comparisons|
    comparisons.each do |(total, result)|
      context "when item total is #{total} and price is 1000" do
        it { expect(subject.call(total, 1000)).to eq result }
      end
    end
  end

  describe 'Default rule' do
    subject(:rule) { pricing_rules::DEFAULT_RULE }

    include_examples 'calculations and results', [
      [0, 0],
      [1, 1000],
      [2, 2000],
      [3, 3000],
      [4, 4000],
      [5, 5000]
    ]
  end

  describe 'GR1 rule' do
    subject(:rule) { pricing_rules::RULES['GR1'] }

    include_examples 'calculations and results', [
      [0, 0],
      [2, 1000],
      [3, 2000],
      [4, 2000],
      [5, 3000]
    ]
  end

  describe 'SR1 rule' do
    subject(:rule) { pricing_rules::RULES['SR1'] }

    include_examples 'calculations and results', [
      [0, 0],
      [2, 2000],
      [3, 1350],
      [4, 1800],
      [5, 2250]
    ]
  end

  describe 'CF1 rule' do
    subject(:rule) { pricing_rules::RULES['CF1'] }

    include_examples 'calculations and results', [
      [0, 0],
      [2, 2000],
      [3, 2000],
      [4, 2666],
      [5, 3333]
    ]
  end
end
