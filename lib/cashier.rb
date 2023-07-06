# frozen_string_literal: true

require 'rubygems'

require_relative 'entities/product_entity'
require_relative 'use_cases/checkout'

class Cashier
  def self.call
    'OK'
  end
end
