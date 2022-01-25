class AddIsActiveProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :isActive, :boolean
  end
end
