class AddTypeToProductStock < ActiveRecord::Migration[7.2]
  def change
    add_column :product_stocks, :type, :boolean, null: false
  end
end
