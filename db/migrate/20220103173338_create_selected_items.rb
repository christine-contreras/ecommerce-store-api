class CreateSelectedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :selected_items do |t|
      t.integer :quantity
      t.belongs_to :cart, null: true, foreign_key: true
      t.belongs_to :order, null: true, foreign_key: true
      t.belongs_to :sku, null: false, foreign_key: true

      t.timestamps
    end
  end
end
