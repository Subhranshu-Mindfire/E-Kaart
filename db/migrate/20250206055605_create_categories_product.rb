class CreateCategoriesProduct < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
