class CreateOrder < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.float :price
      t.text :address
      t.integer :order_status, default: 0
      t.integer :payment_status
      
      t.timestamps
    end
  end
end
