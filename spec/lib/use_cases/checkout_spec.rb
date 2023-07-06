# frozen_string_literal: true

RSpec.describe Checkout do
  subject(:checkout) { described_class.new(pricing_rules) }

  let(:coffee) { build(:product_entity, :coffee) }
  let(:green_tea) { build(:product_entity, :green_tea) }
  let(:strawberries) { build(:product_entity, :strawberries) }

  let(:pricing_rules) do
    {
      coffee.code => coffee,
      green_tea.code => green_tea,
      strawberries.code => strawberries
    }
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

    before { checkout.scan('GR1') }

    it { is_expected.to eq('£3.11') }
  end
end
