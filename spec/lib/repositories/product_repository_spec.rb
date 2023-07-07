# frozen_string_literal: true

RSpec.describe ProductRepository do
  subject(:product_repository) { described_class }

  describe '#all' do
    subject(:all) { product_repository.all }

    context 'with actual file' do
      let(:coffee) { build(:product_entity, :coffee) }
      let(:green_tea) { build(:product_entity, :green_tea) }
      let(:strawberries) { build(:product_entity, :strawberries) }

      let(:products) do
        {
          coffee.code => coffee,
          green_tea.code => green_tea,
          strawberries.code => strawberries
        }
      end

      it { is_expected.to match(products) }
    end

    context 'with invalid attributes' do
      before { stub_const('ProductRepository::PRODUCTS', [{ foo: :bar }]) }

      it { is_expected.to be_empty }
    end

    context 'with invalid product' do
      before { stub_const('ProductRepository::PRODUCTS', [{ code: nil }]) }

      it { is_expected.to be_empty }
    end
  end
end
