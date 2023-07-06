# frozen_string_literal: true

RSpec.describe Cashier do
  subject(:cashier) { described_class }

  describe '#call' do
    subject(:call) { cashier.call }

    it { is_expected.to eq 'OK' }
  end
end
