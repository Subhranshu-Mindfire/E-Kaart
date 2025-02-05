class CreateJoinTableProductCategory < ActiveRecord::Migration[7.2]
  def change
    create_join_table :products, :categories do |t|
      t.index :product_id
      t.index :category_id
    end
  end
end
