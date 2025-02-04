class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private 

  def user_not_authorized
    flash[:alert] = 'Not Authorized'
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    home_users_path
  end

end
