class ChangeSkusTableIncludeQuantity < ActiveRecord::Migration[6.1]
  def change
    remove_column :skus, :order_id 
    remove_column :skus, :cart_id
    add_column :skus, :quantity, :integer 
  end
end
