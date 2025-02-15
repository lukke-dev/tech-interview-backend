# frozen_string_literal: true

FactoryBot.define do
  factory :cart_entity, class: "Carts::CartEntity" do
    id { Faker::Number.number(digits: 3) }
    abandoned { false }
    updated_at { DateTime.now }
  end
end