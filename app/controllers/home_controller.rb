class HomeController < ApplicationController
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
      @electronics = Category.find_by(name: "Electronics").products
      @skin_cares = Category.find_by(name: "Skin Care").products
      @home_decors = Category.find_by(name: "Home Decors").products
      @categories = Category.all
    end
  end
end