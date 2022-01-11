class Category < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories
    has_one_attached :image

    validates :name, {presence: true}
    validates :isActive, {inclusion: { in: [ true, false ] }}

   # grab url of image
  def image_url 
    if self.image.attached?
      self.image.url(expires_in: 8.hours)
    end
  end

end
