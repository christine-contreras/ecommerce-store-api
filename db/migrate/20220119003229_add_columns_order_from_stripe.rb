class AddColumnsOrderFromStripe < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :invoice, :text 
    add_column :orders, :email, :string 
    change_column :orders, :amount, :decimal, :precision => false, :scale => false
  end
end
