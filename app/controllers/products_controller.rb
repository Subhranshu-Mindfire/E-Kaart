class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products = Product.all.order(created_at: :asc)
    @stock={}
    
    @products.each do |product|
      @stock[product] = product.product_stocks.where(transaction_type: true).pluck(:quantity).sum - product.product_stocks.where(transaction_type: false).pluck(:quantity).sum
    end
    
    authorize @products
  end
  
  def show
    authorize product
  end
  
  def new
    @product = Product.new 
    authorize @product
  end
  
  def create
    @product = Product.new(product_params.merge(user: current_user, category_ids: params[:product][:category_ids]))
    authorize @product 
    if @product.save
      redirect_to products_path, notice: "Product Added Successfully"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  
  def edit
    authorize product
  end
  
  def update
    authorize product
    if params[:product][:categories].blank?
      flash.now[:alert] = "Product Should Have Atleast One Category"
      render :edit, status: :unprocessable_entity
      return
    end
    if @product.update(product_params)
      @product.update(category_ids: params[:product][:categories])
      if current_user.admin?
        redirect_to products_path, notice: "Product Updated Successfully"
      else
        redirect_to products_user_path(current_user), notice: "Product Updated Successfully"
      end
      
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    authorize product
    begin
      @product.destroy
      redirect_to products_path, notice: "Successfully Deleted The Product"
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end

  private
  
  def product
    @product ||= Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404', alert: "Product Not Found"
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, images:[] )
  end
end