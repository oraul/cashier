# frozen_string_literal: true

require 'rubygems'
require 'json'

require_relative 'entities/product_entity'
require_relative 'repositories/pricing_rule_repository'
require_relative 'use_cases/checkout'
require_relative 'use_cases/pricing_rules'

class Cashier
  def self.call
    'OK'
  end
end
