class AddDefaultToAddress < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :default, :boolean
  end
end
