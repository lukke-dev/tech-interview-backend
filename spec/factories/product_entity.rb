# frozen_string_literal: true

FactoryBot.define do
  factory :product_entity, class: "Products::ProductEntity" do
    id { Faker::Number.number(digits: 3) }
    name { Faker::Books::CultureSeries.book }
    price { Faker::Number.decimal }
  end
end