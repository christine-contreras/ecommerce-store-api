class RemoveScaleFromSkuPrice < ActiveRecord::Migration[6.1]
  def change
    change_column :skus, :price, :decimal, :precision => false, :scale => false
  end
end
