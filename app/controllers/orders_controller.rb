class OrdersController < BeforeOrderController
  def my_order
    @my_orders = current_user.orders.order(created_at: :desc)
  end

  def create
    cart_items = CartItem.where(user_id: current_user.id)
    
    cart_items.each do |cart_item|
      order = Order.create(user_id: current_user.id, quantity: cart_item.quantity, product_id: cart_item.product_id, price: (cart_item.quantity * Product.find(cart_item.product_id).price),  address: "Bhubaneswar, Odisha", payment_status: :success, order_status: :placed)
      cart_item.destroy
    end
    redirect_to orders_path, notice: "Order Placed Successfully"
  end
end