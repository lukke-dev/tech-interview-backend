module CartProducts
  module UseCases
    class DestroyCartProductUseCase
      def execute(cart_id:, product_id:)
        cart = find_cart_by_id_repository.execute(id: cart_id)

        return ["Cart not found", :not_found] if cart.nil?

        cart_product = find_cart_product_by_product_and_cart_repository.execute(cart_id:, product_id:)

        return ["Product not found in cart", :not_found] if cart_product.nil?

        cart_product.destroy
        cart = find_cart_by_id_repository.execute(id: cart.id, includes: [cart_products: :product])

        if cart.products.length > 0
          cart.update(abandoned: false) if cart.abandoned # Nao estava especificado, mas estou resetando o carrinho abandonado caso tenha alguma alteracao

          response = {
            id: cart.id,
            products: cart.products,
            total_price: cart.total_price
          }
        else 
          cart.destroy
          response = {}
        end

        [response, :ok]
      end

      private

      def find_cart_by_id_repository
        Carts::Repositories::FindCartByIdRepository.new
      end

      def find_cart_product_by_product_and_cart_repository
        CartProducts::Repositories::FindCartProductByProductAndCartRepository.new
      end
    end
  end
end