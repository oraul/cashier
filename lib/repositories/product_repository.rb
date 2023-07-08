# frozen_string_literal: true

class ProductRepository
  ALL = JSON.parse(File.read('fixtures/products.json'), symbolize_names: true)

  def self.all(product_entity: ProductEntity)
    ALL.inject([]) do |memo, element|
      memo << product_entity.new(element.slice(:code, :name, :price_in_cents))
    end
  end
end
