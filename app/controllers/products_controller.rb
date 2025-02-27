class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    if params[:search]
      @products = Product.all.select{|product| product.name.upcase.include?(params[:search].upcase)}
      @title = params[:search]
      @categories = Category.all
    elsif params[:category]
      @name = Category.find(params[:category]).name
      @products = Category.find(params[:category]).products
      @categories = Category.all
    else
      @products = Product.all.order(created_at: :asc)
      @categories = Category.all
    end
  end
  
  def show
    product
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
    if params[:product][:category_ids].blank?
      flash.now[:alert] = "Product Should Have Atleast One Category"
      render :edit, status: :unprocessable_entity
      return
    end
    if @product.update(product_params.merge(category_ids: params[:product][:category_ids]))
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

  def product_stocks
    begin
      @product_stocks = ProductStock.where(product_id: params[:id]).order(created_at: :desc)
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
    params.require(:product).permit(:search, :name, :description, :price, images:[] )
  end
end