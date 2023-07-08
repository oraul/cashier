# frozen_string_literal: true

require 'rubygems'
require 'logger'
require 'forwardable'
require 'json'

require_relative 'adapters/logger_adapter'
require_relative 'entities/product_entity'
require_relative 'repositories/product_repository'
require_relative 'use_cases/checkout'
require_relative 'use_cases/pricing_rule_use_case'

class Cashier
  def self.call
    'OK'
  end
end
