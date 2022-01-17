class SelectedItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :sku

  validates :quantity, {presence: true }

  def price
    self.quantity * self.sku.price
  end
end
