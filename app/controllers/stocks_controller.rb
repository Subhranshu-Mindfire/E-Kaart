class StocksController < ApplicationController
  
  def index
    if current_user.admin? 
      @stocks = ProductStock.all.order(created_at: :desc)
    else
      @stocks = ProductStock.where(product_id: current_user.product_ids) 
    end
  end

  def create
    @stock = ProductStock.new(stock_params)
    if @stock.save
      if current_user.admin?
        redirect_to products_path, notice: "Stock Transaction Successful"
      else
        redirect_to products_user_path(current_user), notice: "Stock Transaction Successful"
      end
    else
      flash[:alert] = @stock.errors.full_messages.to_sentence
      render :new ,status: :unprocessable_entity
    end
  end

  private

  def stock_params
    params.require(:product_stock).permit(:quantity,:transaction_type,:product_id)
  end
end