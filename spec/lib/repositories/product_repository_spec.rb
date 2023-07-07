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

    it 'is expected to allow file read once' do
      allow(File).to receive(:read).with('fixtures/products.json').and_call_original

      2.times { all }

      expect(File).to have_received(:read).with('fixtures/products.json').once
    end
  end
end
