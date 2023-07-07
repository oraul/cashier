# frozen_string_literal: true

RSpec.describe ProductRepository do
  subject(:product_repository) { described_class }

  describe '#all' do
    subject(:all) { product_repository.all }

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
end
