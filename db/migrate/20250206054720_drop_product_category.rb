class DropProductCategory < ActiveRecord::Migration[7.2]
  def change
    drop_table :categories_products
  end
end
