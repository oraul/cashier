# frozen_string_literal: true

class Checkout
  attr_reader :total_in_cents

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @total_in_cents = 0
  end

  def scan(item)
    @total_in_cents += @pricing_rules[item].price_in_cents
  end

  def total
    "£#{@total_in_cents / 100.0}"
  end
end
