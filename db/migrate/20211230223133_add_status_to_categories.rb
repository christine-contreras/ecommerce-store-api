class AddStatusToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :status, :string
  end
end
