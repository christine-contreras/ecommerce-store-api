class AddImageKeySkus < ActiveRecord::Migration[6.1]
  def change
    add_column :skus, :image_key, :text
  end
end
