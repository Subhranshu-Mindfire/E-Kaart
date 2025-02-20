class AddAddressOrder < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :address, foreign_key: true, index: true
  end
end
