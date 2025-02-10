class ChangeProductStock < ActiveRecord::Migration[7.2]
  def change
    change_column :product_stocks, :transaction_type, :integer, using: 'transaction_type::integer'
  end
end
