class CartItemsController < ApplicationController

  def index
    if user_signed_in?
      @cart_items = CartItem.where(user_id: current_user.id)
    else
      @cart_items = session[:cart_items]
    end
  end

  def create
    if user_signed_in?
      @cart_item = CartItem.new(cart_params)
      if current_user.cart_items.pluck(:product_id).include?(cart_params[:product_id])
        cart_item = current_user.cart_items.find_by(:product_id)
        cart_item.quantity += 1
        cart_item.save
        redirect_to cart_items_path, notice: "Added To Cart Successfully"
      else
        if @cart_item.save
          redirect_to cart_items_path, notice: "Added To Cart Successfully"
        else
          flash.now[:alert] = @cart_item.errors.full_messages.join(', ')
          render :new, status: :unprocessable_entity
        end
      end
    else
      if session[:cart_items].blank?
        session[:cart_items] = []
      else
        if session[:cart_items].pluck(:product_id).include?(cart_params[:product_id])
          session[:cart_items].find_by(:product_id).quantity += 1
          redirect_to cart_items_path, notice: "Added To Cart Successfully"
        end
          session[:cart_items].push(cart_params)
          redirect_to cart_items_path, notice: "Added To Cart Successfully"
      end
    end
    
  end

  private

  def cart

  end

  def cart_params
    params.require(:cart_item).permit(:quantity, :product_id, :user_id)
  end
end