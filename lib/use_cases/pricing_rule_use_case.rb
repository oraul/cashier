# frozen_string_literal: true

module PricingRuleUseCase
  extend Loggable

  RULES = {
    'GR1' => lambda do |total, price|
      ((total / 2) + (total % 2)) * price
    end,
    'SR1' => lambda do |total, price|
      total >= 3 ? total * 450 : total * price
    end,
    'CF1' => lambda do |total, price|
      total_in_cents = total * price
      total_in_cents = total_in_cents * 2 / 3 if total >= 3
      total_in_cents
    end
  }.freeze

  DEFAULT_RULE = lambda do |total, price|
    total * price
  end

  def self.call(product_repository: ProductRepository)
    product_repository.all.each_with_object({}).with_index do |(product, memo), index|
      if product.valid?
        product.rule = RULES[product.code] || DEFAULT_RULE
        memo[product.code] = product
      else
        log_error("PricingRuleUseCase.call: Product##{index} is invalid (#{product.errors})")
      end
    end
  end
end
