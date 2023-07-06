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
    context 'when scan coffee' do
      before do
        checkout.scan('GR1')
      end

      it { expect(checkout.total_in_cents).to eq(311) }
    end

    context 'when scan two items' do
      before do
        checkout.scan('GR1')
        checkout.scan('SR1')
      end

      it { expect(checkout.total_in_cents).to eq(811) }
    end
  end

  describe '.total' do
    subject(:total) { checkout.total }

    before { checkout.scan('GR1') }

    it { is_expected.to eq('£3.11') }
  end
end
