class OrdersController < BeforeOrderController

  skip_before_action :verify_authenticity_token, only: [:create]

  def my_order
    @my_orders = current_user.orders.order(created_at: :desc).page(params[:page])
  end

  def index
    if current_user.owner?
      @orders = Order.all
    end
  end

  def new
    @address= Address.new
    @cart_items = CartItem.where(user_id: current_user.id).order(:created_at)
    @total = @cart_items.inject(0){ |sum,item| sum + (Product.find(item["product_id"]).price * item["quantity"].to_i) }
    @razorpay_order = Razorpay::Order.create amount: ((@total.to_i)+50)*100, currency: 'INR', receipt: 'TEST'
  end

  def create
    if Razorpay::Utility.verify_payment_signature(verify_data)
      cart_items = CartItem.where(user_id: current_user.id)
      if params[:id].blank?
        flash[:alert] = "Order Address Can Not Be Blank"
        redirect_to checkout_path
      else
        order = Order.create(user_id: current_user.id, address_id: params[:id])
        
        cart_items.each do |cart_item|
          order_item = OrderItem.create(order_id: order.id, quantity: cart_item.quantity, product_id: cart_item.product_id, price: (cart_item.quantity * Product.find(cart_item.product_id).price),  address: "Bhubaneswar, Odisha", payment_status: :success)
          ProductStock.create(quantity: cart_item.quantity, product_id: cart_item.product_id, transaction_type: "out")
          cart_item.destroy
        end
        OrderMailer.order_confirmed_email(current_user, order).deliver_later
        redirect_to orders_path, notice: "Payment Successful, Your Order is Placed!"
      end
    else
      flash[:alert] = "Payment verification failed. Please try again."
      redirect_to orders_path
    end
  end
end

private
def verify_data
  razorpay_payment_id = params[:razorpay_payment_id]
  razorpay_order_id = params[:razorpay_order_id]
  razorpay_signature = params[:razorpay_signature]
  data = {
    razorpay_order_id: razorpay_order_id,
    razorpay_payment_id: razorpay_payment_id,
    razorpay_signature: razorpay_signature
  }
end
  
