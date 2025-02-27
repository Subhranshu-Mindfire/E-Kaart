module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @products = Product.all.order(created_at: :asc)
      @stock={}
      @products.each do |product|
        @stock[product] = product.count_stocks
      end
      authorize Product
    end
  end
end