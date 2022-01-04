class ChangeColumnsSkusDefaultsTrue < ActiveRecord::Migration[6.1]
  def change
    change_column_null :skus, :order_id, true
    change_column_null :skus, :cart_id, true
  end
end
