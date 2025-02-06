class ProductController < ApplicationController
  before_action :product, only: [:show, :edit, :destroy]

  def index
    @products = Product.all
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

  private
  
  def product
    @product ||= Product.find(params[:id])
  end
end