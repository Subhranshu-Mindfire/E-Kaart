class AddColumnToAddress < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :recipient_name , :string
    add_column :addresses, :phone_number , :string
  end
end
