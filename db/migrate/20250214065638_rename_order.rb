class RenameOrder < ActiveRecord::Migration[7.2]
  def change
    rename_column :orders, :order_status, :status
  end
end
