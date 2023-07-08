# frozen_string_literal: true

RSpec.describe LoggerAdapter do
  subject(:logger_adapter) { described_class }

  it { is_expected.to respond_to :unknown }
  it { is_expected.to respond_to :fatal }
  it { is_expected.to respond_to :error }
  it { is_expected.to respond_to :warn }
  it { is_expected.to respond_to :info }
  it { is_expected.to respond_to :debug }
end
