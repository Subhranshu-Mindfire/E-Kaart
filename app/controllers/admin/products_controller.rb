module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @products = Product.all.order(created_at: :asc)
      @stock={}
      @products.each do |product|
        @stock[product] = product.product_stocks.where(transaction_type: true).pluck(:quantity).sum - product.product_stocks.where(transaction_type: false).pluck(:quantity).sum
      end
      authorize Product
    end
  end
end