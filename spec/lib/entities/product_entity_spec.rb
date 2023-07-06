# frozen_string_literal: true

RSpec.describe ProductEntity do
  subject(:product_entity) { build(:product_entity, :coffee) }

  describe 'attributes' do
    let(:attributes) do
      {
        code: 'CF1',
        name: 'Coffee',
        price_in_cents: 1123
      }
    end

    it { is_expected.to have_attributes(attributes) }
  end

  describe '.price' do
    subject(:price) { product_entity.price }

    it { is_expected.to eq '£11.23' }
  end
end
