class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home]

  def index
    @users = User.all
    authorize @users    
  end

  def new
    @user = User.new
    @roles = Role.where.not(title: "Admin")  
  end

  def create
    @user = User.new(user_params)
    roles = role_params[:roles]

    if roles.present?
      roles = roles.map! { |role| role.to_i }
      @user.roles = Role.where(id: roles)
    end

    if @user.save
      redirect_to home_path, notice: "Created Successfully"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize user
    @roles = Role.where.not(title: "Admin") 
  end

  def show
    authorize user
  end

  def update
    authorize user
    if @user.update(user_params)
      roles = params[:user][:roles]
      if roles.blank?
        flash.now[:alert] = "User must have at least one role"
        render :edit, status: :unprocessable_entity
        return
      end
      roles.map! { |role| role.to_i }
      @user.update(role_ids: roles)
      if user.admin?
        redirect_to users_path, notice: "User Updated Successfully"
      else
        redirect_to root_path, notice: "User Updated Successfully"
      end
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize user 
    begin
      @user.destroy
      redirect_to users_path, notice: "Successfully Deleted"
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end

  def home
    @products = Product.all
    @electronics = Category.find_by(name: "Electronics").products
    @skin_cares = Category.find_by(name: "Skin Care").products
    @home_decors = Category.find_by(name: "Home Decors").products
    @categories = Category.all
    if user_signed_in?
      render :home
      return
    else
      redirect_to root_path
      return
    end
  end

  def products
    @products = Product.where(user_id: current_user.id)
    # authorize @products
    @stock={}
    @products.each do |product|
      @stock[product] = product.product_stocks.where(transaction_type: 1).pluck(:quantity).sum - product.product_stocks.where(transaction_type: 0).pluck(:quantity).sum
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :status)
  end

  def role_params
    params.require(:user).permit(roles: [])  
  end
end
