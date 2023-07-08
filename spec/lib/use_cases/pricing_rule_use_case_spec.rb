# frozen_string_literal: true

RSpec.describe PricingRuleUseCase do
  subject(:pricing_rules) { described_class }

  shared_examples 'calculations and results' do |comparisons|
    comparisons.each do |(total, result)|
      context "when item total is #{total} and price is 1000" do
        it { expect(subject.call(total, 1000)).to eq result }
      end
    end
  end

  describe '.call' do
    subject(:call) { pricing_rules.call(product_repository:) }

    let(:product_repository) { class_double(ProductRepository, all: products) }

    let(:products) do
      [
        build(:product_entity, :coffee),
        build(:product_entity, :green_tea),
        build(:product_entity, :strawberries),
        build(:product_entity, :default),
        build(:product_entity)
      ]
    end

    let(:result) do
      {
        products[0].code => products[0],
        products[1].code => products[1],
        products[2].code => products[2],
        products[3].code => products[3]
      }
    end

    it { is_expected.to eq result }

    context 'when is called' do
      before { call }

      it 'is expected to set rule CF1 on coffee' do
        expect(products[0].rule).to eq pricing_rules::RULES['CF1']
      end

      it 'is expected to set rule GR1 on green tea' do
        expect(products[1].rule).to eq pricing_rules::RULES['GR1']
      end

      it 'is expected to set rule SR1 on strawberries' do
        expect(products[2].rule).to eq pricing_rules::RULES['SR1']
      end

      it 'is expected to set default rule on default' do
        expect(products[3].rule).to eq pricing_rules::DEFAULT_RULE
      end
    end

    context 'with invalid product' do
      it 'is not expected to receive rules on invalid product' do
        call
        expect(products[4].rule).to be_nil
      end

      it 'is expected to log error on invalid product' do
        message = 'PricingRuleUseCase.call: Product#4 is invalid ' \
                  '({:code=>["is empty"], :name=>["is empty"], :price_in_cents=>["is not integer"]})'

        allow(described_class).to receive(:log_error).with(message)

        call

        expect(described_class).to have_received(:log_error).with(message)
      end
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
