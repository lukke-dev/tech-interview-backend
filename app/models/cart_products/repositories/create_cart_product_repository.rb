module CartProducts
  module Repositories
    class CreateCartProductRepository
      def execute(data:)
        CartProducts::CartProductEntity.upsert(data, update_only: [:quantity], unique_by: [:cart_id, :product_id])
      end
    end
  end
end