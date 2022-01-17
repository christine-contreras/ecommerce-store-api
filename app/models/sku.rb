class Sku < ApplicationRecord
  belongs_to :product
  has_many :selected_items, dependent: :destroy
  has_one_attached :image
  validates :size, {presence: true }
  validates :color, {presence: true }
  validates :price, {presence: true, numericality: true}

  # grab url of image
  def image_url 
    if self.image.attached?
      self.image.url(expires_in: 8.hours)
    end
  end

end
