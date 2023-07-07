# frozen_string_literal: true

ProductEntity = Struct.new(:code, :name, :price_in_cents, :rule, keyword_init: true) do
  def price
    "£#{price_in_cents / 100.0}"
  end
end
