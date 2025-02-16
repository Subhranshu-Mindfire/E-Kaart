class CreateOrderTable < ActiveRecord::Migration[7.2]
  def change
    create_table :order do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
