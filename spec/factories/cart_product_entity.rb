# frozen_string_literal: true

FactoryBot.define do
  factory :cart_product_entity, class: "CartProducts::CartProductEntity" do
    id { Faker::Number.number(digits: 3) }
    quantity { Faker::Number.number(digits: 3) }
  end
end