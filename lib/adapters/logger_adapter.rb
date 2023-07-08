# frozen_string_literal: true

class LoggerAdapter
  class << self
    extend Forwardable

    def client
      @client ||= Logger.new("log/#{ENV.fetch('CASHIER_ENV', 'development')}.log")
    end

    def_delegators :client, :unknown, :fatal, :error, :warn, :info, :debug
  end

  private_class_method :client
end
