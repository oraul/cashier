# frozen_string_literal: true

RSpec.describe Checkout do
  subject(:checkout) { described_class.new(pricing_rules) }

  let(:coffee) { build(:product_entity, :coffee) }
  let(:green_tea) { build(:product_entity, :green_tea) }
  let(:strawberries) { build(:product_entity, :strawberries) }

  let(:pricing_rules) do
    PricingRules.apply(
      {
        coffee.code => coffee,
        green_tea.code => green_tea,
        strawberries.code => strawberries
      }
    )
  end

  describe '.scan' do
    context 'when scan green tea once' do
      before do
        checkout.scan(green_tea.code)
      end

      it { expect(checkout.basket).to eq(green_tea.code => 1) }
    end

    context 'when scan green tea twice' do
      before do
        2.times { checkout.scan(green_tea.code) }
      end

      it { expect(checkout.basket).to eq(green_tea.code => 2) }
    end

    context 'when scan coffee and green tea' do
      before do
        checkout.scan(coffee.code)
        checkout.scan(green_tea.code)
      end

      it { expect(checkout.basket).to eq(coffee.code => 1, green_tea.code => 1) }
    end

    context 'when scan unknown code' do
      it { expect { checkout.scan('unknown') }.to output(/ERROR: unknown code is not found/).to_stdout }

      it do
        checkout.scan('unknown')
        expect(checkout.basket).to be_empty
      end
    end
  end

  describe '.total' do
    subject(:total) { checkout.total }

    before do
      basket.each { |product_code| checkout.scan(product_code) }
    end

    context 'when is scanned GR1,SR1,GR1,GR1,CF1' do
      let(:basket) { %w[GR1 SR1 GR1 GR1 CF1] }

      it { is_expected.to eq '£22.45' }
    end

    context 'when is scanned GR1,GR1' do
      let(:basket) { %w[GR1 GR1] }

      it { is_expected.to eq '£3.11' }
    end

    context 'when is scanned SR1,SR1,GR1,SR1' do
      let(:basket) { %w[SR1 SR1 GR1 SR1] }

      it { is_expected.to eq '£16.61' }
    end

    context 'when is scanned GR1,CF1,SR1,CF1,CF1' do
      let(:basket) { %w[GR1 CF1 SR1 CF1 CF1] }

      it { is_expected.to eq '£30.57' }
    end
  end
end
