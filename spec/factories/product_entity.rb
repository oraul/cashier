# frozen_string_literal: true

FactoryBot.define do
  factory :product_entity, class: ProductEntity do
    trait(:green_tea) do
      code { 'GR1' }
      name { 'Green tea' }
      price_in_cents { 311 }
    end

    trait(:strawberries) do
      code { 'SR1' }
      name { 'Strawberries' }
      price_in_cents { 500 }
    end

    trait(:coffee) do
      code { 'CF1' }
      name { 'Coffee' }
      price_in_cents { 1123 }
    end
  end
end
