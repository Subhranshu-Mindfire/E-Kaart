class ProductStocksController < ApplicationController
  
  def index
    if current_user.admin? 
      @product_stocks = ProductStock.all.order(created_at: :desc)
    else
      @product_stocks = ProductStock.where(product_id: current_user.product_ids) 
    end
  end

  def create
    @product_stock = ProductStock.new(stock_params)
    if @product_stock.save
      if current_user.admin?
        redirect_to products_path, notice: "Stock Transaction Successful"
      else
        redirect_to products_user_path(current_user), notice: "Stock Transaction Successful"
      end
    else
      flash[:alert] = @product_stock.errors.full_messages.to_sentence
      render :new ,status: :unprocessable_entity
    end
  end

  def edit
    product_stock
  end

  def update
    product_stock
    if @product_stock.update(stock_params)
      redirect_to product_stocks_path, notice: "Stock Transaction Updated Successfully"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end
  
  def destroy
    product_stock
    begin
      @product_stock.destroy
      redirect_to product_stocks_path, notice: "Successfully Deleted The Transaction"
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end


  private

  def stock_params
    params.require(:product_stock).permit(:quantity,:transaction_type,:product_id)
  end

  def product_stock
    @product_stock ||= ProductStock.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404', alert: "Stock Record Not Found"
  end
end