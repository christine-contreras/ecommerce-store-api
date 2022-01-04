class SelectedItem < ApplicationRecord
  belongs_to :cart
  belongs_to :order
  belongs_to :sku
end
