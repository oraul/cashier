# frozen_string_literal: true

RSpec.describe ProductEntity do
  subject(:product_entity) do
    build(:product_entity, :coffee, rule: ->(total, price_in_cents) { total * price_in_cents })
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

  describe 'validations' do
    before do
      product_entity.public_send(:"#{attribute_name}=", nil)
      product_entity.valid?
    end

    context 'when code is empty' do
      let(:attribute_name) { :code }

      it { is_expected.not_to be_valid }
      it { expect(product_entity.errors).to match(code: ['is empty']) }
    end

    context 'when name is empty' do
      let(:attribute_name) { :name }

      it { is_expected.not_to be_valid }
      it { expect(product_entity.errors).to match(name: ['is empty']) }
    end

    context 'when price_in_cents is not integer' do
      let(:attribute_name) { :price_in_cents }

      it { is_expected.not_to be_valid }
      it { expect(product_entity.errors).to match(price_in_cents: ['is not integer']) }
    end
  end

  describe '.calculate_in_cents' do
    subject(:calculate_in_cents) { product_entity.calculate_in_cents(2) }

    it { is_expected.to eq 2246 }
  end
end
