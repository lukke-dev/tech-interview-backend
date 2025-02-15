# frozen_string_literal: true

require "rails_helper"

RSpec.describe Carts::UseCases::CreateOrUpdateCartUseCase do
  describe "#execute" do
    let(:cart) { build(:cart_entity) }
    let(:product) { build(:product_entity) }
  
    context "Quando o product_id não existir" do
      it "Deve retornar uma mensagem de erro com status :not_found" do
        allow_any_instance_of(Carts::Repositories::CreateCartRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(Products::Repositories::FindProductByIdRepository).to receive(:execute).and_return(nil)
        response = Carts::UseCases::CreateOrUpdateCartUseCase.new.execute(cart_id: nil, params: { product_id: product.id, quantity: Faker::Number.number(digits: 3) })

        expect(response).to eq(["Product with id #{product.id} not found", :not_found])
      end
    end

    context "Quando a quantity não for um numero inteiro maior que 1" do
      it "Deve retornar uma mensagem de erro com status :unprocessable_entity" do
        allow_any_instance_of(Carts::Repositories::CreateCartRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(Products::Repositories::FindProductByIdRepository).to receive(:execute).and_return(product)
        response = Carts::UseCases::CreateOrUpdateCartUseCase.new.execute(cart_id: nil, params: { product_id: product.id, quantity: -50 })

        expect(response).to eq(["Quantity must be greater than 1", :unprocessable_entity])
      end
    end

    context "Quando tiver sucesso ao adicionar um item ao carrinho" do
      let(:updated_cart) { build(:cart_entity) }

      it "Deve retornar o carrinho com status :ok" do
        allow_any_instance_of(Carts::Repositories::CreateCartRepository).to receive(:execute).and_return(cart)
        allow_any_instance_of(Products::Repositories::FindProductByIdRepository).to receive(:execute).and_return(product)
        allow_any_instance_of(Carts::Repositories::FindCartByIdRepository).to receive(:execute).and_return(updated_cart)
        response = Carts::UseCases::CreateOrUpdateCartUseCase.new.execute(cart_id: nil, params: { product_id: product.id, quantity: 5 })

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
  end
end
