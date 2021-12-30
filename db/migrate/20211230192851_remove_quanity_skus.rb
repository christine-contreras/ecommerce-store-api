class RemoveQuanitySkus < ActiveRecord::Migration[6.1]
  def change
    remove_column :skus, :quantity
  end
end
