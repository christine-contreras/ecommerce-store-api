class AddImageKeyCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :image_key, :text
  end
end
