# frozen_string_literal: true

module ProductRepository
  module_function

  def all(product_entity: ProductEntity)
    @all ||= JSON.parse(File.read('fixtures/products.json'), symbolize_names: true).map! do |product|
      product_entity.new(product)
    end
  end
end
