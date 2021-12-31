class UpdateCategoriesStatus < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :status 
    add_column :categories, :isActive, :boolean
  end
end
