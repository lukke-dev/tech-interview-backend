module Carts
  module UseCases
    class GetCartUseCase
      def execute(cart_id:)
        cart = find_cart_by_id_repository.execute(id: cart_id, includes: [cart_products: :product])
        response = {}

        if cart.present?
          response = {
            id: cart.id,
            products: cart.products,
            total_price: cart.total_price
          }
        end

        [response, :ok]
      end

      private

      def find_cart_by_id_repository
        Carts::Repositories::FindCartByIdRepository.new
      end
    end
  end
end