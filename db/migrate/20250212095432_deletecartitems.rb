class Deletecartitems < ActiveRecord::Migration[7.2]
  def change
    drop_table :cart_items
  end
end
