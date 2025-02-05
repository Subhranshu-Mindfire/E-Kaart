class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
