# frozen_string_literal: true

require "rails_helper"

RSpec.describe Carts::UseCases::GetCartUseCase do
  describe "#execute" do
    context "Quando não houver um carrinho existente" do
      it "Deve retornar um objeto vazio com status :no_content" do
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(nil)
        response = Carts::UseCases::GetCartUseCase.new.execute(cart_id: nil)

        expect(response).to eq([{}, :no_content])
      end
    end

    context "Quando houver um carrinho existente" do
      it "Deve retornar o carrinho com status :ok" do
        cart = build(:cart_entity)
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(cart)
        response = Carts::UseCases::GetCartUseCase.new.execute(cart_id: cart.id)

        expect(response).to eq([
          {
            id: cart.id,
            products: cart.products,
            total_price: cart.total_price
          },
          :ok
        ])
      end
    end
  end
end
