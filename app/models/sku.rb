class Sku < ApplicationRecord
  belongs_to :order
  belongs_to :cart
  belongs_to :product

  has_many_attached :image

  validates :size, {presence: true }
  validates :color, {presence: true }
  validates :quantity, {presence: true, numericality: true}
end
