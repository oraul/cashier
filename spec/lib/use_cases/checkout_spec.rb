# frozen_string_literal: true

RSpec.describe Checkout do
  subject(:checkout) { described_class.new(pricing_rules) }

  let(:coffee) { build(:product_entity, :coffee, rule: ->(total, price) { total * price }) }
  let(:green_tea) { build(:product_entity, :green_tea, rule: ->(total, price) { total * price }) }
  let(:strawberries) { build(:product_entity, :strawberries, rule: ->(total, price) { total * price }) }

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

    context 'when scan not_found code' do
      it 'is expected to log error' do
        message = 'NOT_FOUND code is not found'

        allow(LoggerAdapter).to receive(:error).with(message)

        checkout.scan('NOT_FOUND')

        expect(LoggerAdapter).to have_received(:error).with(message)
      end

      it do
        checkout.scan('NOT_FOUND')
        expect(checkout.basket).to be_empty
      end
    end
  end

  describe '.total' do
    subject(:total) { checkout.total }

    before do
      [
        coffee.code,
        green_tea.code,
        strawberries.code
      ].each { |code| checkout.scan(code) }
    end

    it { is_expected.to eq '£19.34' }
  end
end
