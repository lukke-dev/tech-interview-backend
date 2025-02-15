module Carts
  class CartEntity < ApplicationRecord
    self.table_name = "carts"
    
    has_many :cart_products, class_name: "CartProducts::CartProductEntity", foreign_key: "cart_id", dependent: :destroy

    def total_price
      self.cart_products.map{ |cart_product| cart_product.quantity * cart_product.product.price }.sum
    end

    def products
      self.cart_products.map do |cart_product|
        product = cart_product.product
        quantity = cart_product.quantity
        {
          id: product.id,
          name: product.name,
          quantity: quantity,
          unit_price: product.price,
          total_price: product.price * quantity
        }
      end
    end
  end
end
