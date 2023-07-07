# frozen_string_literal: true

module ProductRepository
  module_function

  def all(product_entity: ProductEntity)
    JSON.parse(File.read('fixtures/products.json'), symbolize_names: true)
        .each_with_object({}) do |product, memo|
          memo[product[:code]] = product_entity.new(product)
        end
  end
end
