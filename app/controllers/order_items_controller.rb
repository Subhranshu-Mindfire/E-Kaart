class OrderItemsController < BeforeOrderController
  def update
    order_item = OrderItem.find(params[:id])
    order_item.update(status: params[:order_item][:status])
    redirect_to user_orders_path(current_user), notice: "Updated Successfully"
  end
end