# frozen_string_literal: true

module Loggable
  %i[unknown fatal error warn info debug].each do |log_type|
    define_method("log_#{log_type}") do |description|
      LoggerAdapter.public_send(log_type, description)
    end
  end
end
