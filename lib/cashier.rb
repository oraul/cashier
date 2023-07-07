# frozen_string_literal: true

require 'rubygems'

require_relative 'entities/product_entity'
require_relative 'use_cases/checkout'
require_relative 'use_cases/pricing_rules'

class Cashier
  def self.call
    'OK'
  end
end
