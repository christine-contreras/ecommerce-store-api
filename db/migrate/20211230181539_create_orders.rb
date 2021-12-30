class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.decimal :amount, precision: 6, scale: 2
      t.text :address
      t.string :status

      t.timestamps
    end
  end
end
