# frozen_string_literal: true

class DummyClass
  extend ::Loggable
end

RSpec.describe Loggable do
  shared_examples 'a concern logger method' do |log_type|
    before do
      allow(LoggerAdapter).to receive(log_type).with('foobar')
    end

    it "is expected to receive LoggerAdapter.#{log_type}" do
      DummyClass.public_send(:"log_#{log_type}", 'foobar')
      expect(LoggerAdapter).to have_received(log_type).with('foobar')
    end
  end

  describe '#log_unknown' do
    it_behaves_like  'a concern logger method', :unknown
  end

  describe '#log_fatal' do
    it_behaves_like  'a concern logger method', :fatal
  end

  describe '#log_error' do
    it_behaves_like  'a concern logger method', :error
  end

  describe '#log_warn' do
    it_behaves_like  'a concern logger method', :warn
  end

  describe '#log_info' do
    it_behaves_like  'a concern logger method', :info
  end

  describe '#log_debug' do
    it_behaves_like  'a concern logger method', :debug
  end
end
