# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if User.find_by(email: params[:user][:email]).blank?
      redirect_to new_user_session_path, alert: "User Doesn't Exist"
      return  
    elsif User.find_by(email: params[:user][:email]).inactive?
      redirect_to new_user_session_path, notice: "Your Status Is Inactive !!! Contact Support" 
    else
      super
      unless session[:cart_items].blank?
        session[:cart_items].each do |cart_item|
         CartItem.create(cart_item.merge(user_id: current_user.id))
        end
        session[:cart_items] = []
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  # def after_sign_in_path_for(resource)
  #   redirect_to home_users_path, notice: "Signed In Succesfully"
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in) do |user_params|
  #     user_params.permit(:email, :password)
  #   end
  # end
end
