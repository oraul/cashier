# frozen_string_literal: true

class ProductRepository
  PRODUCTS = JSON.parse(File.read('fixtures/products.json'), symbolize_names: true)

  def self.all(product_entity: ProductEntity)
    PRODUCTS.each_with_object({}).with_index do |(element, memo), _index|
      product = product_entity.new(element.slice(:code, :name, :price_in_cents))
      memo[product.code] = product if product.valid?
    end
  end
end
