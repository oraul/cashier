# frozen_string_literal: true

ProductEntity = Struct.new(:code, :name, :price_in_cents, :rule, keyword_init: true) do
  def calculate_in_cents(total)
    rule.call(total, price_in_cents)
  end
end
