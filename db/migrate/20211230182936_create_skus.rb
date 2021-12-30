class CreateSkus < ActiveRecord::Migration[6.1]
  def change
    create_table :skus do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.string :size
      t.string :color
      t.integer :quantity
      t.decimal :price, precision: 6, scale: 2

      t.timestamps
    end
  end
end
