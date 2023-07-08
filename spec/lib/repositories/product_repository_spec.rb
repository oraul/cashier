# frozen_string_literal: true

RSpec.describe ProductRepository do
  subject(:product_repository) { described_class }

  describe '#all' do
    subject(:all) { product_repository.all }

    let(:products) do
      [
        build(:product_entity, :coffee),
        build(:product_entity, :green_tea),
        build(:product_entity, :strawberries)
      ]
    end

    it { is_expected.to match_array(products) }
  end
end
