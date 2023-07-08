# frozen_string_literal: true

class Checkout
  include Loggable

  attr_reader :basket

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @basket = Hash.new(0)
  end

  def scan(item)
    return log_error("#{item} code is not found") unless @pricing_rules.key?(item)

    @basket[item] += 1
  end

  def total
    total_in_cents = 0

    @basket.each do |code, total|
      total_in_cents += @pricing_rules[code].calculate_in_cents(total)
    end

    "£#{total_in_cents / 100.0}"
  end
end
