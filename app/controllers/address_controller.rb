class AddressController < ApplicationController
  def index
    @addresses = Address.all.order(created_at: :desc)
  end

  def create
    @address = Address.new(address_params.merge(user_id: current_user.id))

    if address_params[:default] == "1" && !Address.find_by(user_id: current_user.id, default: true).blank?
      Address.find_by(user_id: current_user.id, default: true).update(default: false)
    end 

    if @address.save
      redirect_to checkout_path, notice: "Address Saved Successfully"
    else
      flash[:alert] = @address.errors.full_messages.to_sentence
      render "orders/new" ,status: :unprocessable_entity
    end
  end

  def edit
    authorize address
  end

  def update
    authorize address
    if @address.update(address_params)
      redirect_to addresses_path, notice: "Address Updated Successfully"
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end
  
  def destroy
    authorize address
    begin
      @address.destroy
      redirect_to addresses_path, notice: "Successfully Deleted The Transaction"
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404'
    end
  end


  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :pin_code, :default, :phone_number, :recipient_name)
  end

  def address
    @address ||= Address.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to '/404', alert: "Stock Record Not Found"
  end
end