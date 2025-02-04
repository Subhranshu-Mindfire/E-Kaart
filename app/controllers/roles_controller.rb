class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :role, only: [:edit, :update, :destroy, :show]
  before_action :authorize_role

  def index
    @roles = Role.all
    authorize @roles
  end

  def new
    @role = Role.new
    authorize @role
  end

  def show
    authorize role
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: "Role Created Successfully"
    else
      flash.now[:alert] = @role.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    authorize role
  end

  def update
    authorize @role
    if @role.update(role_params)
      redirect_to roles_path, notice: "Role Updated Successfully"
    else
      res = ""

      @role.errors.messages.each_key do |k| 
        res += (k.to_s + " " + @role.errors.messages[k][0] + ", ")
      end
      flash.now[:alert] = res
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @role
    @role.destroy
    redirect_to roles_path, notice: "Role Deleted Successfully"
  end

  private

  def role_params
    params.require(:role).permit(:title, :description)
  end

  def role
    @role ||= Role.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404', alert: "Role not found"
  end

  def authorize_role
    authorize current_user
    rescue Pundit::NotAuthorizedError
      redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
