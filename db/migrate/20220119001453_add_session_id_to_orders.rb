class AddSessionIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :session_id, :text
  end
end
