module CartProducts
  module Repositories
    class FindCartProductByProductAndCartRepository
      def execute(cart_id:, product_id:)
        CartProducts::CartProductEntity.find_by(cart_id:, product_id:)
      end
    end
  end
end