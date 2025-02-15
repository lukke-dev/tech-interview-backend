module CartProducts
  class CartProductEntity < ApplicationRecord
    self.table_name = "cart_products"

    belongs_to :cart, class_name: "Carts::CartEntity"
    belongs_to :product, class_name: "Products::ProductEntity"

    validates :cart_id, uniqueness: { scope: :product_id }
    validates_numericality_of :quantity, greater_than_or_equal_to: 1
  end
end
