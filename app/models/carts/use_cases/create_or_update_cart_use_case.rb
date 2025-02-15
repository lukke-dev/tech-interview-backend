module Carts
  module UseCases
    class CreateOrUpdateCartUseCase
      def execute(cart_id:, params:)

        if cart_id.present?
          cart = find_cart_by_id_repository.execute(id: cart_id)
          cart = create_cart_repository.execute if cart.nil?
        else
          cart = create_cart_repository.execute
        end

        product = find_product_by_id_repository.execute(id: params[:product_id])
        
        return ["Product with id #{params[:product_id]} not found", :not_found] if product.nil?

        quantity = params[:quantity]

        return ["Quantity must be greater than 1", :unprocessable_entity] if !quantity.is_a?(Integer) || quantity < 1

        create_cart_product_repository.execute(data: params.merge(cart_id: cart.id))

        cart = find_cart_by_id_repository.execute(id: cart.id, includes: [cart_products: :product])
        
        cart.update(abandoned: false) if cart.abandoned # Nao estava especificado, mas estou resetando o carrinho abandonado caso tenha alguma alteracao

        response = {
          id: cart.id,
          products: cart.products,
          total_price: cart.total_price
        }

        [response, :ok]
      end

      private

      def find_cart_by_id_repository
        Carts::Repositories::FindCartByIdRepository.new
      end

      def create_cart_product_repository
        CartProducts::Repositories::CreateCartProductRepository.new
      end

      def find_product_by_id_repository
        Products::Repositories::FindProductByIdRepository.new
      end

      def create_cart_repository
        Carts::Repositories::CreateCartRepository.new
      end
    end
  end
end