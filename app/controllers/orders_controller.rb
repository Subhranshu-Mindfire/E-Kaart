class OrdersController < BeforeOrderController
  def my_order
    @my_orders = current_user.orders.order(created_at: :desc)
  end

  def create
    cart_items = CartItem.where(user_id: current_user.id)
    if params[:order].blank?
      flash[:alert] = "Order Address Can Not Be Blank"
      redirect_to checkout_path
    else
      order = Order.create(user_id: current_user.id, address_id: params[:order][:address_id])
      
      cart_items.each do |cart_item|
        order_item = OrderItem.create(order_id: order.id, quantity: cart_item.quantity, product_id: cart_item.product_id, price: (cart_item.quantity * Product.find(cart_item.product_id).price),  address: "Bhubaneswar, Odisha", payment_status: :success)
        ProductStock.create(quantity: cart_item.quantity, product_id: cart_item.product_id, transaction_type: "out")
        cart_item.destroy
      end
      OrderMailer.order_confirmed_email(current_user, order).deliver_later
      redirect_to orders_path, notice: "Order Placed Successfully"
    end
  end

  def index
    if current_user.owner?
      @orders = Order.all
    end
  end

  def new
    @cart_items = CartItem.where(user_id: current_user.id).order(:created_at)
    @total = @cart_items.inject(0){ |sum,item| sum + (Product.find(item["product_id"]).price * item["quantity"].to_i) }
  end
end