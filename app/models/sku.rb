class Sku < ApplicationRecord
  belongs_to :product
  has_one_attached :image
  validates :size, {presence: true }
  validates :color, {presence: true }
  validates :price, {presence: true, numericality: true}
end
