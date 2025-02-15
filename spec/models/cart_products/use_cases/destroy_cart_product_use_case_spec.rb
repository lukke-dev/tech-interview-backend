# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartProducts::UseCases::DestroyCartProductUseCase do
  describe "#execute" do
    let(:cart) { build(:cart_entity) }
    let(:updated_cart) { build(:cart_entity) }
    let(:product) { build(:product_entity) }

    context "Quando o cart_id não existir" do
      it "Deve retornar uma mensagem de erro com status :not_found" do
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(nil)
        response = CartProducts::UseCases::DestroyCartProductUseCase.new.execute(cart_id: cart.id, product_id: product.id)

        expect(response).to eq(["Cart not found", :not_found])
      end
    end

    context "Quando o product_id não existir no carrinho" do
      it "Deve retornar uma mensagem de erro com status :not_found" do
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(CartProducts::Repositories::FindCartProductByProductAndCartRepository).to receive(:execute).and_return(nil)
        response = CartProducts::UseCases::DestroyCartProductUseCase.new.execute(cart_id: cart.id, product_id: product.id)

        expect(response).to eq(["Product not found in cart", :not_found])
      end
    end

    context "Quando tiver sucesso ao remover um item do carrinho" do
      it "Deve retornar o carrinho com status :ok" do
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(CartProducts::Repositories::FindCartProductByProductAndCartRepository).to receive(:execute).and_return(product)
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(updated_cart)
        allow(updated_cart).to receive_message_chain(:products, :length).and_return(1)

        response = CartProducts::UseCases::DestroyCartProductUseCase.new.execute(cart_id: cart.id, product_id: product.id)

        expect(response).to eq([
          {
            id: updated_cart.id,
            products: updated_cart.products,
            total_price: updated_cart.total_price
          },
          :ok
        ])
      end
    end

    context "Quando o carrinho ficar vazio ao remover o produto" do
      it "Deve retornar um objeto vazio com status :ok" do
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(CartProducts::Repositories::FindCartProductByProductAndCartRepository).to receive(:execute).and_return(product)
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(updated_cart)
        allow(updated_cart).to receive_message_chain(:products, :length).and_return(0)
        response = CartProducts::UseCases::DestroyCartProductUseCase.new.execute(cart_id: cart.id, product_id: product.id)

        expect(response).to eq([{}, :ok])
      end
    end
  end
end
