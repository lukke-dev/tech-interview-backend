class CartsController < ApplicationController
  def get    
    response, status = Carts::UseCases::GetCartUseCase.new.execute(
      cart_id: session[:cart_id],
    )

    render json: response, status: status
  end

  def create
    body_params = params.require(:cart).permit(:product_id, :quantity)
    
    response, status = Carts::UseCases::CreateOrUpdateCartUseCase.new.execute(
      cart_id: session[:cart_id],
      params: body_params
    )

    if status == :ok
      session[:cart_id] = response[:id]
    end

    render json: response, status: status
  end

  def patch
    # Se o carrinho nao existir, eu deveria criar? nao esta especificado na definicao dessa rota.

    body_params = params.require(:cart).permit(:product_id, :quantity)
    
    response, status = Carts::UseCases::CreateOrUpdateCartUseCase.new.execute(
      cart_id: session[:cart_id],
      params: body_params
    )

    if status == :ok
      session[:cart_id] = response[:id]
    end

    render json: response, status: status
  end

  def destroy
    response, status = CartProducts::UseCases::DestroyCartProductUseCase.new.execute(
      cart_id: session[:cart_id],
      product_id: params[:product_id]
    )

    render json: response, status: status
  end
end
