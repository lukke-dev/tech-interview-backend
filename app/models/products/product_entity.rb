module Products
  class ProductEntity < ApplicationRecord
    self.table_name = "products"

    has_many :cart_products, class_name: "CartProducts::CartProductEntity", foreign_key: "product_id", dependent: :destroy

    validates_presence_of :name, :price
    validates_numericality_of :price, greater_than_or_equal_to: 0
  end
end
