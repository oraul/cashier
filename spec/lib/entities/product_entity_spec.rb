# frozen_string_literal: true

RSpec.describe ProductEntity do
  subject(:product_entity) do
    build(:product_entity, :coffee, rule: lambda { |total, price_in_cents|
                                            total * price_in_cents
                                          })
  end

  describe 'attributes' do
    let(:attributes) do
      {
        code: 'CF1',
        name: 'Coffee',
        price_in_cents: 1123,
        rule: kind_of(Proc)
      }
    end

    it { is_expected.to have_attributes(attributes) }
  end

  describe '.calculate_in_cents' do
    subject(:calculate_in_cents) { product_entity.calculate_in_cents(2) }

    it { is_expected.to eq 2246 }
  end
end
