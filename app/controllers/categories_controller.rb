class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    authorize @categories
  end

  def new
    @category = Category.new
    authorize @category
  end

  def show
    authorize category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "category Created Successfully"
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    authorize category
  end

  def update
    authorize category
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category Updated Successfully"
    else
      flash.now[:alert] = category.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize category
    @category.destroy
    redirect_to categories_path, notice: "category Deleted Successfully"
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :parent_id)
  end

  def category
    @category ||= Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404', alert: "Category Not Found"
  end
end
