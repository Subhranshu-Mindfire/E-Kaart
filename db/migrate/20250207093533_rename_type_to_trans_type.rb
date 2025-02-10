class RenameTypeToTransType < ActiveRecord::Migration[7.2]
  def change
    rename_column :product_stocks, :type, :transaction_type
  end
end
