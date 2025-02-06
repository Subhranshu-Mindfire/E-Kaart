class AddUserToProduct < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :user, foreign_key: true
  end
end
