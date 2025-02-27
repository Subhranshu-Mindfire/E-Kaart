class CartItemsController < ApplicationController
  def index
    if user_signed_in?
      @cart_items = CartItem.where(user_id: current_user.id).order(:created_at)
    else
      @cart_items = session[:cart_items]
      if @cart_items.blank?
        @cart_items = []
      end
    end
    @total = @cart_items.inject(0){ |sum,item| sum + (Product.find(item["product_id"]).price * item["quantity"].to_i) }
  end

  def create
    if user_signed_in?
      @cart_item = CartItem.new(cart_params)
      
      if current_user.cart_items.pluck(:product_id).include?(cart_params[:product_id].to_i)
        cart_item = current_user.cart_items.find_by(product_id: cart_params[:product_id].to_i)
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
      end

      cart_item = session[:cart_items].find { |item| item["product_id"] == cart_params[:product_id] }

      if cart_item
        cart_item["quantity"] = (cart_item["quantity"].to_i + 1).to_s
        notice_message = "Added To Cart Successfully"
      else
        session[:cart_items] << cart_params
        notice_message = "Added To Cart Successfully"
      end
      redirect_to cart_items_path, notice: notice_message
    end
  end

  def increment
    if user_signed_in?
      @cart_item = CartItem.find(params[:id])
      if @cart_item.quantity == 10
        redirect_to cart_items_path, alert: "Maximum 10 Quantity Can Be Ordered"
      elsif @cart_item.product.count_stocks <= @cart_item.quantity
        redirect_to cart_items_path, alert: " Sorry, This Quantity Is Not Availabe"
      else
        @cart_item.update(quantity: (@cart_item.quantity + 1))
        redirect_to cart_items_path, notice: "Quantity Added Successfully"
      end
    else
      cart_item = session[:cart_items][params[:id].to_i]
      cart_item["quantity"] = (cart_item["quantity"].to_i + 1).to_s
      redirect_to cart_items_path, notice: "Quantity Added Successfully"
    end
    
  end

  def decrement
    if user_signed_in?
      @cart_item = CartItem.find(params[:id])
      if @cart_item.quantity == 1
        redirect_to cart_items_path, alert: "Quantity Can Not Be Zero"
      else
        @cart_item.update(quantity: (@cart_item.quantity - 1))
        redirect_to cart_items_path, notice: "Quantity Reduced Successfully"
      end
    else
      cart_item = session[:cart_items][params[:id].to_i]
      if cart_item["quantity"] == "1"
        redirect_to cart_items_path, alert: "Quantity Can Not Be Zero"
      else
        cart_item["quantity"] = (cart_item["quantity"].to_i - 1).to_s
        redirect_to cart_items_path, notice: "Quantity Reduced Successfully"
      end
    end
  end

  def destroy
    if user_signed_in?
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      redirect_to cart_items_path, notice: "Item Removed From Cart Successfully"
    else
      session[:cart_items].delete_at(params[:id].to_i)
      redirect_to cart_items_path, notice: "Item Removed From Cart Successfully"
    end
  end

  private

  def cart

  end

  def cart_params
    params.require(:cart_item).permit(:quantity, :product_id, :user_id)
  end
end