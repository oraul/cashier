# frozen_string_literal: true

module PricingRules
  RULES = {
    'GR1' => lambda do |total, price|
      ((total / 2) + (total % 2)) * price
    end,
    'SR1' => lambda do |total, price|
      total_in_cents = total * price
      total_in_cents -= 450  if total >= 3
      total_in_cents
    end,
    'CF1' => lambda do |total, price|
      total_in_cents = total * price
      total_in_cents = total_in_cents * 2 / 3 if total >= 3
      total_in_cents
    end
  }.freeze

  def self.apply(products)
    products.each do |_code, product|
      product.rule = RULES[product.code]
    end

    products
  end
end
