class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    drop_table :order

    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :order_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.float :price
      t.text :address
      t.integer :status, default: 0
      t.integer :payment_status

      t.timestamps
    end
  end
end
